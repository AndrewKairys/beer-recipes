class RemoveColumnFromHops < ActiveRecord::Migration[5.1]
  def change
    remove_column :hops, :amount
    remove_column :hops, :addition_time
  end
end
