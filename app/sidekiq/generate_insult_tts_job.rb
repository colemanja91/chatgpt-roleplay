class GenerateInsultTtsJob
  include Sidekiq::Job

  def perform(insult_session_message_id)
    message = InsultSessionMessage.find(insult_session_message_id)
    ElevenlabsService.new.insult_text_to_speech(message)
  end
end
