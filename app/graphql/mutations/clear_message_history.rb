module Mutations
  class ClearMessageHistory < BaseMutation
    field :character, Types::CharacterType

    argument :character_id, ID, required: true

    def resolve(character_id:)
      character = Character.find(character_id)
      character.messages.destroy_all

      {character: character.reload}
    end
  end
end
