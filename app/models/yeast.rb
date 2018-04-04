class Yeast < ApplicationRecord
  has_many :recipe_yeasts
  has_many :recipes, through: :recipe_yeasts

  validates :brand, presence: true
  validates :variety, presence: true
end
