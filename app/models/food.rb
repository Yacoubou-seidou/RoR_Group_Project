class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes, through: :recipe_foods, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :user_id, presence: true
end
