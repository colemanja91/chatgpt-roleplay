class InsultCronService
  MIN_MINUTES_BTW_RUNS = 3.minutes
  MAX_MINUTES_BTW_RUNS = 6.minutes

  def run!
    active_sessions = InsultSession.where(ended_at: nil).where.not(started_at: nil)

    active_sessions.each do |session|
      next if session.safeguard!
      next unless run_for_session?(session)
      InsultChatJob.perform_async(session.id)
    end
  end

  private

  def run_for_session?(session)
    # if no messages then exit (one is queued on start)
    return false if session.insult_session_messages.count == 0

    # if last was > max duration then run
    return true if session.insult_session_messages.last.created_at < MAX_MINUTES_BTW_RUNS.ago

    # Don't run if under min duration
    return false if session.insult_session_messages.last.created_at > MIN_MINUTES_BTW_RUNS.ago

    # default to a 1-in-3 otherwise
    [true, false, false].sample
  end
end
