class AddVoiceIdExternalToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :xi_voice_id, :string, null: true
    add_column :characters, :xi_similarity_boost, :decimal, null: true
    add_column :characters, :xi_stability, :decimal, null: true
    add_column :characters, :xi_style, :decimal, null: true
  end
end
