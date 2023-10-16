# frozen_string_literal: true

module Types
  class VoiceType < Types::BaseObject
    field :id, ID, null: false
    field :xi_voice_id, ID
    field :xi_similarity_boost, Float
    field :xi_stability, Float
    field :xi_style, Float
  end
end
