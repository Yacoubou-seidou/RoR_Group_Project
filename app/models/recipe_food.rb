class RecipeFood < ApplicationRecord
  belongs_to :food

  belongs_to :recipe

  def food_cost
    food.quantity.present? && food.price.present? ? food.quantity * food.price : 0
  end
end
