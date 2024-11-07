class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.text :description
      t.text :ingredients

      t.timestamps
    end
  end
end
