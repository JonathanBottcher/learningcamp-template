class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.text :ingredients, null: false

      t.timestamps
    end
  end
end
