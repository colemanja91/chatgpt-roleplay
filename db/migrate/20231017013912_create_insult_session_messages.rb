class CreateInsultSessionMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :insult_session_messages do |t|
      t.string :content, null: false
      t.string :tts_file_path, null: true
      t.timestamps
    end

    add_reference :insult_session_messages, :insult_session, foreign_key: true, null: false
    add_reference :insult_session_messages, :insult_session_character, foreign_key: true, null: false
  end
end
