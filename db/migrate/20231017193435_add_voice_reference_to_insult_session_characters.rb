class AddVoiceReferenceToInsultSessionCharacters < ActiveRecord::Migration[7.0]
  def change
    add_reference :insult_session_characters, :voice, foreign_key: true, null: true
  end
end
