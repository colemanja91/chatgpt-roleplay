class CharacterChatService
  MAX_TOKENS = 4096

  def initialize(character:)
    @character = character
  end

  attr_reader :character

  def response(message:)
    # wrap in transaction so we don't save the user message
    # if the OpenAI API call fails
    character.transaction do
      character.messages.create!(role: "user", content: message)

      response = openai.get_chat_completion(messages: prepared_messages)
      character.messages.create!(role: "assistant", content: response)
      puts "Response: #{response}"
    end
  rescue OpenaiService::OpenaiError => e
    puts "Oh noes! #{e.inspect}"
  end

  # We want the most recent messages, but returned in
  # order of least-to-most recent
  # system message always needs to be first
  def prepared_messages
    # 200 is an arbitrary token size buffer because we are working with estimates
    message_token_limit = MAX_TOKENS - character.system_message_tokens - 200
    message_set = character.messages.from_desc_token_sum.where("from_recent_token_sum < ?", message_token_limit).order(id: :desc)
    messages = message_set.map { |m| {role: m.role, content: m.content} }
    messages << {role: "system", content: character.system_message}

    puts "Token count: #{estimated_token_count(messages)}"

    messages.reverse
  end

  private

  def estimated_token_count(messages)
    messages.sum { |m| OpenAI.rough_token_count(m[:content]) }
  end

  def openai
    @openai ||= OpenaiService.new
  end
end
