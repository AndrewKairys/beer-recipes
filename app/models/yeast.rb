class Yeast < ApplicationRecord
  has_many :recipe_yeasts
  has_many :recipes, through: :recipe_yeasts

  validates :variety, uniqueness: true
  validates :brand, presence: true
  validates :variety, presence: true

  def brand_and_variety
    "#{brand} - #{variety}"
  end
end
