module Mutations
  class StartInsultSession < BaseMutation
    field :insult_session, Types::InsultSessionType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      session = InsultSession.find(id)
      session.start!

      {insult_session: session}
    end
  end
end
