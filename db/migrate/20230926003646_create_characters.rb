class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, index: {unique: true, name: "unique_characters"}, null: false
      t.string :system_message, null: false
      t.timestamps
    end
  end
end
