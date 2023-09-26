class CreateSummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :summaries do |t|
      t.string :content, null: false
      t.timestamps
    end

    add_reference :summaries, :character, foreign_key: true
  end
end
