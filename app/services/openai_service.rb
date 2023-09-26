class OpenaiService
  DEFAULT_MODEL = "gpt-3.5-turbo".freeze

  class OpenaiError < StandardError; end

  def get_chat_completion(messages:, temperature: 1)
    # temperature seems to break if higher than 1.8
    parameters = {
      model: DEFAULT_MODEL,
      messages: messages,
      temperature: temperature
    }

    puts "Parameters: #{parameters}"

    response = client.chat(
      parameters: parameters
    )

    error = response.fetch("error", nil)
    if error
      raise OpenaiError.new(error)
    end

    response.dig("choices", 0, "message", "content")
  end

  private

  def client
    @client ||= OpenAI::Client.new(access_token: Setting.openai(:access_token))
  end
end
