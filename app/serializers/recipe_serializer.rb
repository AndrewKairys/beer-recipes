class RecipeSerializer < ActiveModel::Serializer
  attributes :name, :boil_time, :efficiency
  has_many :recipe_hops
  has_many :hops
end
