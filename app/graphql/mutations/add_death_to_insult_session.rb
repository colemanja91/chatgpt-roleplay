module Mutations
  class AddDeathToInsultSession < BaseMutation
    field :insult_session, Types::InsultSessionType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      session = InsultSession.find(id)
      session.add_death!

      {insult_session: session}
    end
  end
end
