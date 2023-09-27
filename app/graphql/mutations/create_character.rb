module Mutations
  class CreateCharacter < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :name, String, required: true
    argument :system_message, String, required: true

    def resolve(name:, system_message:)
      character = Character.build(name: name, system_message: system_message)

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
