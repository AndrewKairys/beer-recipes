class RecipeSerializer < ActiveModel::Serializer
  attributes :name, :style
  has_many :recipe_hops
  has_many :hops
  belongs_to :user
end
