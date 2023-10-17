# frozen_string_literal: true

module Types
  class InsultSessionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :game, String, null: false
    field :death_counter, Integer, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
