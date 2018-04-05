class AddColumnsToRecipeStyles < ActiveRecord::Migration[5.1]
  def change
    add_column :recipe_styles, :recipe_id, :integer
    add_column :recipe_styles, :style_id, :integer
  end
end
