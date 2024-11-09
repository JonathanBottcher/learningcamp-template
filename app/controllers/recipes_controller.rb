# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = RecipeGeneratorService.new(recipe_params[:ingredients], current_user.id).call

    if @recipe.save
      redirect_to recipes_path, notice: t('views.recipes.create_success')
    else
      render :new, status: :unprocessable_entity
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
