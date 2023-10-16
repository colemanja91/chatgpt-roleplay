module Mutations
  class UpdateVoice < BaseMutation
    field :voice, Types::VoiceType
    field :errors, [String], null: false

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :xi_voice_id, ID, required: false
    argument :xi_similarity_boost, Float, required: false
    argument :xi_stability, Float, required: false
    argument :xi_style, Float, required: false

    def resolve(id:, name:, xi_voice_id:, xi_similarity_boost:, xi_stability:, xi_style:)
      voice = Voice.find(id)
      voice.update(
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
