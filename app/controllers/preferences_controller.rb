class PreferencesController < ApplicationController
  def index
    binding.pry
    @preferences = current_user.preferences
    @pagy, @records = pagy(@preferences)
  end
end