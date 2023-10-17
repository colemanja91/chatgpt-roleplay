class CreateInsultSessionCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :insult_session_characters do |t|
      t.string :description, null: false
      t.timestamps
    end

    add_reference :insult_session_characters, :insult_session, foreign_key: true, null: false
  end
end
