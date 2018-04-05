class RemoveColumnFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :style_id
  end
end
