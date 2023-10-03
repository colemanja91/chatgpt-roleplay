class ElevenlabsService
  MAX_TEXT_LENGTH = 5000

  def text_to_speech(message)
    content = message.content

    if content.length > MAX_TEXT_LENGTH
      puts "Cannot generate TTS for message #{message.id}, length too long"
      return
    end

    character = message.character
    voice_id = character.xi_voice_id || "nlh17gSD8ihOEnpn4DWI"
    similarity_boost = character.xi_similarity_boost || 0
    stability = character.xi_stability || 0
    style = character.xi_style || 0

    speech = client.post(
      "text-to-speech/#{voice_id}",
      {
        model: "eleven_monolingual_v2",
        text: content,
        voice_settings: {
          similarity_boost: similarity_boost,
          stability: stability,
          style: style,
          use_speaker_boost: true
        }
      }
    )

    filename = "message_#{message.id}_tts.mp3"
    filepath = "#{Setting.data(:shared_data_directory)}/#{filename}"
    File.write(filepath, speech)
    message.update(tts_file_path: filename)
  end

  private

  def client
    @client ||= ElevenLabs::Client.new(api_key: Setting.elevenlabs(:api_key))
  end
end
