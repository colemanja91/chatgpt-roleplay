class AddTtsFilePathToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :tts_file_path, :string, null: true
  end
end
