module Mutations
  class SendMessage < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :character_id, ID, required: true
    argument :message, String, required: true

    def resolve(character_id:, message:)
      character = Character.find(character_id)
      service = CharacterChatService.new(character: character)
      response_message = service.send_message(message: message)

      if response_message && service.error.nil?
        GenerateMessageTtsJob.perform_async(response_message.id)
      end

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
