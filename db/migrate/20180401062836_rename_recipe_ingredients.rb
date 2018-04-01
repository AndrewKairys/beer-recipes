class RenameRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    rename_table :recipe_ingredients, :recipe_hops
  end
end
