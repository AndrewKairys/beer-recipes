class Fermentable < ApplicationRecord
  has_many :recipe_fermentables
  has_many :recipes, through: :recipe_fermentables

  validates :name, uniqueness: true
  validates :name, presence: true
end
