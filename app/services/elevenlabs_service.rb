class ElevenlabsService
  MAX_TEXT_LENGTH = 5000.freeze

  def text_to_speech(message)
    content = message.content

    if content.length > MAX_TEXT_LENGTH
      puts "Cannot generate TTS for message #{message.id}, length too long"
      return
    end

    voice_id = "nlh17gSD8ihOEnpn4DWI"
    speech = client.post(
      "text-to-speech/#{voice_id}",
      {
        model: "eleven_monolingual_v2",
        text: content,
        voice_settings: {
          similarity_boost: 0.6,
          stability: 0.35,
          style: 0.8,
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
