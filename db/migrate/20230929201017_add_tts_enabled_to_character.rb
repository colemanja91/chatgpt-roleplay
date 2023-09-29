class AddTtsEnabledToCharacter < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :tts_enabled, :bool, default: false
  end
end
