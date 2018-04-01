class RemoveEffeciencyColumnFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :efficiency
  end
end
