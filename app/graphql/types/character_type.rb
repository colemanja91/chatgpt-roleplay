# frozen_string_literal: true

module Types
  class CharacterType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :system_message, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :system_message_tokens, Integer
    field :tts_enabled, Boolean
    field :openai_model, String
    field :xi_voice_id, ID
    field :xi_similarity_boost, Float
    field :xi_stability, Float
    field :xi_style, Float
    field :context_size, Integer
    field :variable_temperature_enabled, Boolean
    field :avatar_url, String

    field :messages, [MessageType], null: false
    def messages
      object.messages.last(10)
    end
  end
end
