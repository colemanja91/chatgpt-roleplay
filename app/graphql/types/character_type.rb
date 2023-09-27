# frozen_string_literal: true

module Types
  class CharacterType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :system_message, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :system_message_tokens, Integer

    field :messages, [MessageType], null: false
    def messages
      object.messages.last(10)
    end
  end
end
