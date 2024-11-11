# frozen_string_literal: true

class RecipeGeneratorService
  attr_reader :message, :user

  OPENAI_TEMPERATURE = ENV.fetch('OPENAI_TEMPERATURE', 0).to_f
  OPENAI_MODEL = ENV.fetch('OPENAI_MODEL', 'gpt-4')

  def initialize(message, user_id, preferences = [])
    @message = message
    @user = User.find(user_id)
    @preferences = user.preferences
  end

  def call
    check_valid_message_length
    response = message_to_chat_api
    create_recipe(response)
  end

  private

  def check_valid_message_length
    error_msg = I18n.t('api.errors.invalid_message_length')
    raise RecipeGeneratorServiceError, error_msg unless !!(message =~ /\b\w+\b/)
  end

  def message_to_chat_api
    openai_client.chat(parameters: {
                         model: OPENAI_MODEL,
                         messages: request_messages,
                         temperature: OPENAI_TEMPERATURE
                       })
  end

  def request_messages
    system_message + new_message
  end

  def system_message
    [{ role: 'system', content: prompt }]
  end
  
  def preference_info
    @preferences.map { |pref| "Consider this preference: #{pref.description}. Restriction: #{pref.restriction}" }.join('; ')
  end
  
  def prompt
    <<~CONTENT
      You are an expert cooking assistant that generates recipes. Your task is to create a detailed recipe ONLY using the ingredients provided.
       The user has the following preferences:#{preference_info}
      Your response MUST ALWAYS be in JSON format, like this:
          {
          "name": "Recipe Name",
          "description": "Preparation instructions"
        }
    CONTENT
  end

  def new_message
    [
      { role: 'user', content: "Ingredients: #{message}" }
    ]
  end

  def openai_client
    @openai_client ||= OpenAI::Client.new
  end

  def create_recipe(response)
    parsed_response = response.is_a?(String) ? JSON.parse(response) : response
    content = JSON.parse(parsed_response.dig('choices', 0, 'message', 'content'))
    # create recipe here
    recipe = @user.recipes.create(name: content['name'], description: content['description'], ingredients: @message)
    recipe
  rescue JSON::ParserError => exception
    raise RecipeGeneratorServiceError, exception.message
  end
end
