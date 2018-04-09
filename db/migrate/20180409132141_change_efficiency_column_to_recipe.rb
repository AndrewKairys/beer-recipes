class ChangeEfficiencyColumnToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :efficiency, :integer
    remove_column :users, :efficiency
  end
end
