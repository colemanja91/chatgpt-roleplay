# frozen_string_literal: true

module Types
  class VoiceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :xi_voice_id, ID, null: false
    field :xi_similarity_boost, Float, null: false
    field :xi_stability, Float, null: false
    field :xi_style, Float, null: false
  end
end
