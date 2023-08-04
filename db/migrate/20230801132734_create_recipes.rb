class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes, force: :cascade do |t|
      t.string :name
      t.integer :preparation_time
      t.integer :cooking_time
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
