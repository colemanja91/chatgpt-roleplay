module Types
  class InsultSessionMessageType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: false
    field :tts_file_path, String
  end
end
