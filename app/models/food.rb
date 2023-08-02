class Food < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
end
