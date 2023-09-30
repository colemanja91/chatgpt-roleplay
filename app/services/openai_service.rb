class OpenaiService
  DEFAULT_MODEL = "gpt-3.5-turbo".freeze

  class OpenaiError < StandardError; end

  def list_models
    client.models.list["data"].map { |m| {id: m["id"]} }.sort_by { |m| m[:id] }
  end

  def get_chat_completion(messages:, temperature: 1, model: DEFAULT_MODEL)
    # temperature seems to break if higher than 1.8
    parameters = {
      model: model,
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
