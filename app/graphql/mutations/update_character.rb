module Mutations
  class UpdateCharacter < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :system_message, String, required: true

    def resolve(id:, name:, system_message:)
      character = Character.find(id)
      character.update(name: name, system_message: system_message)

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
