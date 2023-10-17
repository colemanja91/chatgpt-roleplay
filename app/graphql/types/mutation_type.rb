module Types
  class MutationType < Types::BaseObject
    field :add_character_to_insult_session, mutation: Mutations::AddCharacterToInsultSession
    field :start_insult_session, mutation: Mutations::StartInsultSession
    field :clear_message_history, mutation: Mutations::ClearMessageHistory
    field :send_message, mutation: Mutations::SendMessage
    field :delete_character, mutation: Mutations::DeleteCharacter
    field :update_character, mutation: Mutations::UpdateCharacter
    field :create_character, mutation: Mutations::CreateCharacter
    field :create_voice, mutation: Mutations::CreateVoice
    field :update_voice, mutation: Mutations::UpdateVoice
    field :delete_voice, mutation: Mutations::DeleteVoice
  end
end
