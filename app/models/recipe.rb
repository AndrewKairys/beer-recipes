class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_hops
  has_many :recipe_fermentables
  has_many :recipe_yeasts
  has_many :hops, through: :recipe_hops
  has_many :fermentables, through: :recipe_fermentables
  has_many :yeasts, through: :recipe_yeasts
end
