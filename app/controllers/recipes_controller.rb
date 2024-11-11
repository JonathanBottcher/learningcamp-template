# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy]
  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def create
    preferences = current_user.preferences

    @recipe = RecipeGeneratorService.new(recipe_params[:ingredients], current_user.id, preferences).call

    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: t('views.recipes.create_success')
    else
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    if @recipe.destroy
      redirect_to recipes_path, notice: t('views.recipes.destroy_success')
    else
      redirect_to recipes_path, alert: t('views.recipes.destroy_failure')
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])

  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :ingredients)
  end
end
