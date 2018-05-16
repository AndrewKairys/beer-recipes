class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :recipe_hops
  has_many :hops
  belongs_to :user
  belongs_to :style
end
