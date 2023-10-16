module Mutations
  class DeleteVoice < BaseMutation
    field :status, String, null: false

    argument :id, ID, required: true

    def resolve(id:)
      Voice.find(id).destroy

      {status: "success"}
    end
  end
end
