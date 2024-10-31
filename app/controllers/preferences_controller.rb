class PreferencesController < ApplicationController
  def index
    @preferences = current_user.preferences
    @pagy, @records = pagy(@preferences)
  end

  def create
    preference_params = params.require(:preference).permit(:name, :description, :restriction)
    @preference = current_user.preferences.build(preference_params)
  end
end
