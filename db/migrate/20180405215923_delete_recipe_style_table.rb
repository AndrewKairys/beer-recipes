class DeleteRecipeStyleTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :recipe_styles
  end
end
