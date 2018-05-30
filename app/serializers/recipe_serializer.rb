class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :recipe_hops
  has_many :hops
  has_many :yeasts
  has_many :fermentables
  has_many :recipe_fermentables
  has_many :comments

  belongs_to :user
  belongs_to :style
end
