class ElevenlabsService
  def text_to_speech(message)
    content = message.content
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

    filename = "#{Setting.data.shared_data_directory}/message_#{message.id}_tts.mp3"
    File.write(filename, speech)
    message.update(tts_file_path: filename)
  end

  private

  def client
    @client ||= ElevenLabs::Client.new(api_key: Setting.elevenlabs(:api_key))
  end
end
