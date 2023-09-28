module Mutations
  class SendMessage < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :character_id, ID, required: true
    argument :message, String, required: true

    def resolve(character_id:, message:)
      character = Character.find(character_id)
      service = CharacterChatService.new(character: character)
      service.send_message(message: message)

      if service.error
        {
          character: nil,
          errors: [service.error]
        }
      else
        {
          character: character,
          errors: []
        }
      end
    end
  end
end
