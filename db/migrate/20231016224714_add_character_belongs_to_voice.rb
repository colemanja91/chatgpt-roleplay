class AddCharacterBelongsToVoice < ActiveRecord::Migration[7.0]
  def change
    add_reference :characters, :voice, foreign_key: true, null: true
  end
end
