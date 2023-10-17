class CreateInsultSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :insult_sessions do |t|
      t.string :name, index: {unique: true, name: "unique_insult_session_names"}, null: false
      t.timestamp :started_at, null: true
      t.timestamp :ended_at, null: true
      t.string :game, null: false
      t.bigint :death_counter, null: false, default: 0
      t.timestamps
    end
  end
end
