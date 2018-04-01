class DeleteColumnsFromRecipeHops < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipe_hops, :yeast_id
    remove_column :recipe_hops, :fermentable_id
  end
end
