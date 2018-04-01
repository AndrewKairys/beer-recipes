class CreateRecipeFermentables < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_fermentables do |t|
      t.integer :recipe_id
      t.integer :fermentable_id

      t.timestamps
    end
  end
end
