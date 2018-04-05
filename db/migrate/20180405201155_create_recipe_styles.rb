class CreateRecipeStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_styles do |t|

      t.timestamps
    end
  end
end
