module Mutations
  class UpdateCharacter < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :system_message, String, required: true
    argument :tts_enabled, Boolean, required: false
    argument :openai_model, String, required: false
    argument :xi_voice_id, ID, required: false
    argument :xi_similarity_boost, Float, required: false
    argument :xi_stability, Float, required: false
    argument :xi_style, Float, required: false

    def resolve(
      id:,
      name:,
      system_message:,
      tts_enabled: false,
      openai_model: nil,
      xi_voice_id: nil,
      xi_similarity_boost: nil,
      xi_stability: nil,
      xi_style: nil
    )
      character = Character.find(id)
      character.update(
        name: name,
        system_message: system_message,
        tts_enabled: tts_enabled,
        openai_model: openai_model,
        xi_voice_id: xi_voice_id,
        xi_similarity_boost: xi_similarity_boost,
        xi_stability: xi_stability,
        xi_style: xi_style
      )

      if character.save
        {
          character: character,
          errors: []
        }
      else
        {
          character: nil,
          errors: character.errors.full_messages
        }
      end
    end
  end
end
