module Mutations
  class RemoveInsultSessionCharacter < BaseMutation
    field :insult_session, Types::InsultSessionType, null: false

    argument :character_id, ID, required: true

    def resolve(character_id:)
      character = InsultSessionCharacter.find(character_id)
      session = character.insult_session
      character.destroy

      {insult_session: session}
    end
  end
end
