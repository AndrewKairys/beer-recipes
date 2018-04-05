class AddColumnToRecipeFermentables < ActiveRecord::Migration[5.1]
  def change
    add_column :recipe_fermentables, :amount, :decimal
  end
end
