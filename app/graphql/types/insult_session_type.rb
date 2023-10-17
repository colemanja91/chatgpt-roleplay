# frozen_string_literal: true

module Types
  class InsultSessionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :game, String, null: false
    field :death_counter, Integer, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true

    field :characters, [InsultSessionCharacterType], null: false
    def characters
      object.insult_session_characters
    end

    field :last_message, InsultSessionMessageType, null: true
    def last_message
      object.insult_session_messages&.last
    end
  end
end
