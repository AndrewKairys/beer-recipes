class Style < ApplicationRecord
  has_many :recipes

  def self.most_popular
    all_styles = all
    amount_of_recipes = all_styles.collect { |style| style.recipes.count }
    all_styles[amount_of_recipes.each_with_index.max[1]]

    # recipe_array = Recipe.all.collect { |recipe| recipe.style }
    # freq = recipe_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    # recipe_array.max_by { |v| freq[v] }
  end

end
