class CreateRecipeStyles < ActiveRecord::Migration
  def change
    create_table :recipe_styles do |t|
      t.references :recipe, index: true, foreign_key: true
      t.references :style, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
