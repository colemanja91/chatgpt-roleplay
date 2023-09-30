class AddOpenAiModelToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :openai_model, :string, null: true
  end
end
