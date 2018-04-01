class CreateRecipeYeasts < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_yeasts do |t|
      t.integer :recipe_id
      t.integer :yeast_id

      t.timestamps
    end
  end
end
