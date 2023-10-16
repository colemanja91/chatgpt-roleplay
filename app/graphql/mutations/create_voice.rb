module Mutations
  class CreateVoice < BaseMutation
    field :voice, Types::VoiceType
    field :errors, [String], null: false

    argument :name, String, required: true
    argument :xi_voice_id, ID, required: true
    argument :xi_similarity_boost, Float, required: true
    argument :xi_stability, Float, required: true
    argument :xi_style, Float, required: true

    def resolve(name:, xi_voice_id: nil, xi_similarity_boost: nil, xi_stability: nil, xi_style: nil)
      voice = Voice.new(
        name: name,
        xi_voice_id: xi_voice_id,
        xi_similarity_boost: xi_similarity_boost,
        xi_stability: xi_stability,
        xi_style: xi_style
      )

      if voice.save
        {
          voice: voice,
          errors: []
        }
      else
        {
          voice: nil,
          errors: voice.errors.full_messages
        }
      end
    end
  end
end
