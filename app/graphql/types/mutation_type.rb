module Types
  class MutationType < Types::BaseObject
    field :clear_message_history, mutation: Mutations::ClearMessageHistory
    field :send_message, mutation: Mutations::SendMessage
    field :delete_character, mutation: Mutations::DeleteCharacter
    field :update_character, mutation: Mutations::UpdateCharacter
    field :create_character, mutation: Mutations::CreateCharacter
    field :create_voice, mutation: Mutations::CreateVoice
    field :update_voice, mutation: Mutations::UpdateVoice
  end
end
