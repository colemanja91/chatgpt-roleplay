module Mutations
  class CreateCharacter < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :name, String, required: true
    argument :system_message, String, required: true
    argument :tts_enabled, Boolean, required: false
    argument :openai_model, String, required: false
    argument :xi_voice_id, ID, required: false
    argument :xi_similarity_boost, Float, required: false
    argument :xi_stability, Float, required: false
    argument :xi_style, Float, required: false
    argument :context_size, Integer, required: false
    argument :variable_temperature_enabled, Boolean, required: false
    argument :avatar_url, String, required: false

    def resolve(
      name:,
      system_message:,
      tts_enabled: false,
      openai_model: nil,
      xi_voice_id: nil,
      xi_similarity_boost: nil,
      xi_stability: nil,
      xi_style: nil,
      context_size: nil,
      variable_temperature_enabled: nil,
      avatar_url: nil
    )
      character = Character.new(
        name: name,
        system_message: system_message,
        tts_enabled: tts_enabled,
        openai_model: openai_model,
        xi_voice_id: xi_voice_id,
        xi_similarity_boost: xi_similarity_boost,
        xi_stability: xi_stability,
        xi_style: xi_style,
        context_size: context_size,
        variable_temperature_enabled: variable_temperature_enabled,
        avatar_url: avatar_url
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
