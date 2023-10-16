class CreateVoices < ActiveRecord::Migration[7.0]
  def change
    create_table :voices do |t|
      t.string :name, index: {unique: true, name: "unique_voice_names"}, null: false
      t.string :xi_voice_id, null: false
      t.decimal :xi_similarity_boost, null: false, default: 0.5
      t.decimal :xi_stability, null: false, default: 0.5
      t.decimal :xi_style, null: false, default: 0.0
      t.timestamps
    end
  end
end
