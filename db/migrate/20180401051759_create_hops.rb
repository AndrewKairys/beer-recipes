class CreateHops < ActiveRecord::Migration[5.1]
  def change
    create_table :hops do |t|
      t.string :name
      t.decimal :amount
      t.integer :alpha_acids
      t.integer :addition_time

      t.timestamps
    end
  end
end
