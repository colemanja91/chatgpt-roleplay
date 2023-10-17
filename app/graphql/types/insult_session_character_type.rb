module Types
  class InsultSessionCharacterType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: false

    field :voice, VoiceType, null: true
    def voice
      object.voice
    end
  end
end
