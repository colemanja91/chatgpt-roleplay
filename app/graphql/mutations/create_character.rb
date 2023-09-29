module Mutations
  class CreateCharacter < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :name, String, required: true
    argument :system_message, String, required: true
    argument :tts_enabled, Boolean, required: false

    def resolve(name:, system_message:, tts_enabled: false)
      character = Character.new(name: name, system_message: system_message, tts_enabled: tts_enabled)

      if character.save
        {
          character: character,
          errors: []
        }
      else
        {
          character: nil,
          errors: character.errors.full_messages
        }
      end
    end
  end
end
