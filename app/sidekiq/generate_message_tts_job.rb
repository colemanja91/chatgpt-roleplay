class GenerateMessageTtsJob
  include Sidekiq::Job

  def perform(message_id)
    message = Message.find(message_id)
    ElevenlabsService.new.text_to_speech(message) if message.character.tts_enabled?
  end
end
