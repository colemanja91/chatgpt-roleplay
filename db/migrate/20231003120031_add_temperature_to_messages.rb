class AddTemperatureToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :temperature, :decimal, null: true
  end
end
