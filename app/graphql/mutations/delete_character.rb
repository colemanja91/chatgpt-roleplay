module Mutations
  class DeleteCharacter < BaseMutation
    field :status, String, null: false

    argument :id, ID, required: true

    def resolve(id:)
      Character.find(id).destroy

      {status: "success"}
    end
  end
end
