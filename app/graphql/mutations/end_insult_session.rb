module Mutations
  class EndInsultSession < BaseMutation
    field :insult_session, Types::InsultSessionType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      session = InsultSession.find(id)
      session.end_session!

      {insult_session: session}
    end
  end
end
