class Style < ApplicationRecord
  has_many :recipes

  def self.most_popular
    amount_of_recipes = all.collect { |style| style.recipes.count }
    all[amount_of_recipes.each_with_index.max[1]]
  end

end
