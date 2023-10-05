class AddContextSizeToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :context_size, :bigint, default: 0
  end
end
