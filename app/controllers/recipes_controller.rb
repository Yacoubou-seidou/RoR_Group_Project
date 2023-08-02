class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  def index
    @recipes = Recipe.includes([:user]).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.includes(:user, recipe_foods: :food).find(params[:id])
  end

  def shopping_list
    @total_value = 0
    recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = recipe.recipe_foods.includes(:food).select do |recipe_food|
      food = recipe_food.food
      user_food = current_user.foods.find_by(name: food.name, measurement_unit: food.measurement_unit)
      @total_value += recipe_food.process_cost(user_food)
      recipe_food.process_quantity(user_food).positive?
    end
    @total_value = @total_value.round(2)
    @items_to_buy = @recipe_foods.count
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    respond_to do |format|
      format.html do
        redirect_to user_recipes_path(user_id: @recipe.user.id), notice: 'Recipe was successfully deleted.'
      end
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to user_recipes_path
    else
      render 'show'
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      @recipe.toggle!(:public)
      respond_to(&:js)
    else
      redirect_to @recipe, alert: 'You do not have permission to perform this action.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
