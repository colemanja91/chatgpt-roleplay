module Types
  class MutationType < Types::BaseObject
    field :delete_character, mutation: Mutations::DeleteCharacter
    field :update_character, mutation: Mutations::UpdateCharacter
    field :create_character, mutation: Mutations::CreateCharacter
  end
end
