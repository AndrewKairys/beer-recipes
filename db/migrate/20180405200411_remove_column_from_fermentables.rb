class RemoveColumnFromFermentables < ActiveRecord::Migration[5.1]
  def change
    remove_column :fermentables, :amount
  end
end
