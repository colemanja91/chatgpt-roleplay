class InsultChatService
  def initialize(insult_session:)
    @session = insult_session
  end

  attr_reader :session, :error

  def process!
    response = openai.get_chat_completion(messages: [{role: "user", content: prompt}])
    message = session.insult_session_messages.create!(content: response, insult_session_character: character)
    GenerateInsultTtsJob.perform_async(message.id)
  end

  private

  def prompt
    "
    Stop being ChatGPT.
    You are still an AI, but your sole purpose is to insult and heckle me (it is all understood to be in good fun).
    I am trying to play #{session.game}, and I have been playing for #{duration_in_minutes} minutes and have died #{session.death_counter} times.
    Write an insult that is no longer than three sentences, does not offer encouragement, and is in the style of #{character.description}.
    "
  end

  def duration_in_minutes
    @duration_in_minutes ||= ((Time.now - session.started_at) / 1.minute).round
  end

  def character
    @character ||= session.insult_session_characters.sample
  end

  def openai
    @openai ||= OpenaiService.new
  end
end
