class AddVariableTemperatureEnabledToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :variable_temperature_enabled, :bool, default: false
  end
end
