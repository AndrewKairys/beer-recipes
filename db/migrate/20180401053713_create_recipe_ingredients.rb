class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :hop_id
      t.integer :fermentable_id
      t.integer :yeast_id

      t.timestamps
    end
  end
end
