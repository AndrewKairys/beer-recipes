class AddColumnToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :style_id, :integer
  end
end
