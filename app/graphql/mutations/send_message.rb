module Mutations
  class SendMessage < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :character_id, ID, required: true
    argument :message, String, required: true
    argument :variable_temp, Boolean, required: false

    def resolve(character_id:, message:, variable_temp: false)
      character = Character.find(character_id)
      service = CharacterChatService.new(character: character)
      service.send_message(message: message, variable_temp: variable_temp)

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
