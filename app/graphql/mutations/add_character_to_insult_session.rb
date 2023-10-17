module Mutations
  class AddCharacterToInsultSession < BaseMutation
    field :insult_session, Types::InsultSessionType, null: false

    argument :id, ID, required: true
    argument :description, String, required: true
    argument :voice_id, ID, required: true

    def resolve(id:, description:, voice_id:)
      session = InsultSession.find(id)
      voice = Voice.find(voice_id)
      session.insult_session_characters.create!(description: description, voice: voice)

      {insult_session: session}
    end
  end
end
