class CreatePreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :preferences do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :restriction, null: false, default: false

      t.timestamps
    end
  end
end
