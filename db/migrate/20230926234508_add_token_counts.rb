class AddTokenCounts < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :system_message_tokens, :bigint, default: 0
    add_column :messages, :tokens, :bigint, default: 0
    add_column :summaries, :tokens, :bigint, default: 0
  end
end
