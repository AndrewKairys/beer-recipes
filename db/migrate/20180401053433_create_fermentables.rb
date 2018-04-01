class CreateFermentables < ActiveRecord::Migration[5.1]
  def change
    create_table :fermentables do |t|
      t.string :name
      t.integer :amount
      t.decimal :pound_per_gallon
      t.decimal :lovibond
      t.integer :diastatic_power

      t.timestamps
    end
  end
end
