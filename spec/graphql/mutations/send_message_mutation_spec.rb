require_relative "../../rails_helper"

RSpec.describe "Send Message Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation SendMessage($input: SendMessageInput!) {
        sendMessage(input: $input) {
          character {
            id
            messages {
              id
            }
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:character) { create(:character) }

  let(:variables) { {input: {characterId: character.id, message: "this is a message for ChatGPT"}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  let(:openai_service) { instance_double(OpenaiService) }

  before do
    allow(OpenaiService).to receive(:new).and_return(openai_service)
    allow(openai_service).to receive(:get_chat_completion).and_return("response")
    allow(GenerateMessageTtsJob).to receive(:perform_async)
  end

  it "calls ChatGPT and persists the messages" do
    expect { subject }.to change { character.messages.count }.by(2)
    expect(openai_service).to have_received(:get_chat_completion)
    expect(GenerateMessageTtsJob).to have_received(:perform_async)
  end
end
