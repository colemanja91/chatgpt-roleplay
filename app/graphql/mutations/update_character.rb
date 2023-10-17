module Mutations
  class UpdateCharacter < BaseMutation
    field :character, Types::CharacterType
    field :errors, [String], null: false

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :system_message, String, required: true
    argument :tts_enabled, Boolean, required: false
    argument :openai_model, String, required: false
    argument :voice_id, ID, required: false
    argument :context_size, Integer, required: false
    argument :variable_temperature_enabled, Boolean, required: false
    argument :avatar_url, String, required: false

    def resolve(
      id:,
      name:,
      system_message:,
      tts_enabled: false,
      openai_model: nil,
      voice_id: nil,
      context_size: nil,
      variable_temperature_enabled: nil,
      avatar_url: nil
    )
      character = Character.find(id)
      character.update(
        name: name,
        system_message: system_message,
        tts_enabled: tts_enabled,
        openai_model: openai_model,
        voice_id: voice_id,
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
