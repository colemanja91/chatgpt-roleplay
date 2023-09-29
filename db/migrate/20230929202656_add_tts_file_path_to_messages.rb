class AddTtsFilePathToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :tts_file_path, :string, null: true
  end
end
