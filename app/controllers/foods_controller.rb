class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = current_user.foods
  end

  def show
    @food = current_user.foods.find(params[:id])
  end

  def new
    @food = current_user.foods.build
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to food_path(@food), notice: 'Food item created successfully.'
    else
      render :new
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food item deleted successfully.'
    else
      redirect_to foods_path, alert: 'Failed to delete this item'
    end
  end

  def general_shopping_list
    @total_value = 0
    @items_to_buy = 0
    @foods = current_user.foods
    @foods.each do |food|
      recipe_food = RecipeFood.find_by(food:)
      next if recipe_food.nil?

      @items_to_buy += 1 if recipe_food.process_quantity(food).positive?
      @total_value += recipe_food.process_cost(food)
    end
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
