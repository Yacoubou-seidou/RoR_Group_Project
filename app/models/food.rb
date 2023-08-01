class Food < ApplicationRecord
  belongs_to :user

  # has_many :recip_foods
  # has_many :recipes,  through: :recip_foods, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
end
