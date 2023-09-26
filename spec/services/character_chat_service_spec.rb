require_relative "../rails_helper"

RSpec.describe CharacterChatService do
  let(:character) { create(:character) }
  let(:subject) { described_class.new(character: character) }

  let(:openai_service) { instance_double(OpenaiService) }

  before do
    allow(OpenaiService).to receive(:new).and_return(openai_service)
  end

  context "preparing messages" do
    before do
      6.times do |index|
        character.messages.create!(role: "user", content: "content_#{index}")
        character.messages.create!(role: "assistant", content: "content_#{index}")
      end
    end

    it "sends messages in the right order" do
      messages = subject.prepared_messages

      expect(messages.first).to eq({role: "system", content: character.system_message})
      expect(messages.second[:content]).to eq("content_1")
      expect(messages.last[:content]).to eq("content_5")
    end

    it "only sends the most recent messages" do
      messages = subject.prepared_messages
      expect(messages.length).to eq(11)
    end
  end

  context "successful request" do
    before do
      allow(openai_service).to receive(:get_chat_completion).and_return("response")
    end

    it "persists both user and assistant messages" do
      expect { subject.response(message: "test") }.to change { character.messages.count }.by(2)
    end
  end

  context "unsuccessful request" do
    before do
      allow(openai_service).to receive(:get_chat_completion).and_raise(OpenaiService::OpenaiError)
    end

    it "does not persist anything" do
      expect { subject.response(message: "test") }.not_to change { character.messages.count }
    end
  end
end
