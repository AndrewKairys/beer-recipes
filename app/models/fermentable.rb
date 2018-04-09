class Fermentable < ApplicationRecord
  has_many :recipe_fermentables
  has_many :recipes, through: :recipe_fermentables

  validates :name, uniqueness: true

  validates :pound_per_gallon, presence: true
  validates :name, presence: true
  validates :lovibond, presence: true
  validates :diastatic_power, presence: true
end
