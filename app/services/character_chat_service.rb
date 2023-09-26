class CharacterChatService
  def initialize(character:)
    @character = character
  end

  attr_reader :character

  def response(message:)
    # wrap in transaction so we don't save the user message
    # if the OpenAI API call fails
    # max tokens: 4,097
    character.transaction do
      character.messages.create!(role: "user", content: message)

      messages = prepared_messages

      response = openai.get_chat_completion(messages: messages)
      character.messages.create!(role: "assistant", content: response)
      puts "Response: #{response}"
    end
  end

  private

  # We want the most recent messages, but returned in
  # order of least-to-most recent
  # system message always needs to be first
  def prepared_messages
    messages = character.messages.order(id: :desc).limit(10).map { |m| {role: m.role, content: m.content} }
    messages << {role: "system", content: character.system_message}

    puts "Token count: #{estimated_token_count(messages)}"

    messages.reverse
  end

  def estimated_token_count(messages)
    messages.sum { |m| OpenAI.rough_token_count(m[:content]) }
  end

  def openai
    @openai ||= OpenaiService.new
  end
end
