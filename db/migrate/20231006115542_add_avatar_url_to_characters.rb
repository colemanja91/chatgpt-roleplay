class AddAvatarUrlToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :avatar_url, :string, null: true
  end
end
