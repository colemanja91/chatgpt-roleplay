class InsultChatJob
  include Sidekiq::Job

  def perform(session_id)
    session = InsultSession.find(session_id)
    InsultChatService.new(insult_session: session).process!
  end
end
