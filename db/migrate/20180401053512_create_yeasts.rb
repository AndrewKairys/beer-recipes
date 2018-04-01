class CreateYeasts < ActiveRecord::Migration[5.1]
  def change
    create_table :yeasts do |t|
      t.string :brand
      t.string :variety

      t.timestamps
    end
  end
end
