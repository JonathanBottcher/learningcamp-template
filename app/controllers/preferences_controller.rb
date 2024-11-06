class PreferencesController < ApplicationController
  before_action :set_preference, only: %i[edit update destroy show]

  def index
    @preferences = current_user.preferences
    @pagy, @records = pagy(@preferences)
  end

  def show
  end

  def new
    @preference = Preference.new
  end

  def edit
  end

  def create
    @preference = current_user.preferences.build(preference_params)

    if @preference.save
      redirect_to preferences_path, notice: 'Preference was created successfully'
    else
      render :new, alert: 'Could not create preference'
    end
  end

  def update
    if @preference.update(preference_params)
      redirect_to @preference, notice: 'Preference was updated successfully'
    else
      render :edit, alert: 'Could not update preference'
    end
  end

  def destroy
    if @preference.destroy
      redirect_to preferences_path, notice: 'Preference was succesfully deleted'
    else
      redirect_to preferences_path, alert: 'Could not delete preference'
    end
  end

  def preference_params
    params.require(:preference).permit(:name, :description, :restriction)
  end

  def set_preference
    @preference = current_user.preferences.find(params[:id])
  end
end
