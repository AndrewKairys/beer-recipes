class AddColumnToRecipeHops < ActiveRecord::Migration[5.1]
  def change
    add_column :recipe_hops, :amount, :decimal
    add_column :recipe_hops, :addition_time, :integer
  end
end
