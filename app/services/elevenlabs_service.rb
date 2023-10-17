class ElevenlabsService
  MAX_TEXT_LENGTH = 5000

  def chat_text_to_speech(message)
    content = message.content

    character = message.character
    voice = character.voice

    speech = generate_audio(content, voice)

    filename = "message_#{message.id}_tts.mp3"
    filepath = "#{Setting.data(:shared_data_directory)}/#{filename}"
    File.write(filepath, speech)
    message.update(tts_file_path: filename)
  end

  def insult_text_to_speech(message)
    content = message.content

    character = message.insult_session_character
    voice = character.voice

    speech = generate_audio(content, voice)

    filename = "insult_message_#{message.id}_tts.mp3"
    filepath = "#{Setting.data(:shared_data_directory)}/#{filename}"
    File.write(filepath, speech)
    message.update(tts_file_path: filename)
  end

  private

  def generate_audio(content, voice)
    if content.length > MAX_TEXT_LENGTH
      puts "Cannot generate TTS for message #{message.id}, length too long"
      return
    end

    voice_id = voice&.xi_voice_id || "nlh17gSD8ihOEnpn4DWI"
    similarity_boost = voice&.xi_similarity_boost || 0
    stability = voice&.xi_stability || 0
    style = voice&.xi_style || 0

    client.post(
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
  end

  def client
    @client ||= ElevenLabs::Client.new(api_key: Setting.elevenlabs(:api_key))
  end
end
