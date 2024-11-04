class CreatePreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :preferences do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.text :description
      t.boolean :restriction, null: false, default: true

      t.timestamps
    end
  end
end
