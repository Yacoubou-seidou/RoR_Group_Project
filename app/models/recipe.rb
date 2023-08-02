class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods
  has_many :foods, through: :recipe_foods, dependent: :destroy
  def total_cost
    recipe_foods.sum(&:food_cost)
  end
end
