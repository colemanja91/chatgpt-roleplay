class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :role, null: false
      t.string :content, null: false
      t.timestamps
    end

    add_reference :messages, :character, foreign_key: true
  end
end
