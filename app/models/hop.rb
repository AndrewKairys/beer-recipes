class Hop < ApplicationRecord
  has_many :recipe_hops
  has_many :recipes, through: :recipe_hops

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :alpha_acids, presence: true
end
