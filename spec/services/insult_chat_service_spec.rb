require_relative "../rails_helper"

RSpec.describe InsultChatService do
  let!(:session) { create(:started_session, death_counter: 5) }
  let!(:character) { create(:insult_session_character, description: "Princess Peach", insult_session: session) }
  let(:subject) { described_class.new(insult_session: session) }

  let(:openai_service) { instance_double(OpenaiService) }

  before do
    allow(OpenaiService).to receive(:new).and_return(openai_service)
    allow(openai_service).to receive(:get_chat_completion).and_return("Wow u r bad")
    allow(GenerateInsultTtsJob).to receive(:perform_async).and_call_original
  end

  it "creates a new message" do
    expect { subject.process! }.to change { session.insult_session_messages.count }.by(1)
  end

  it "calls OpenaiService" do
    subject.process!
    expect(openai_service).to have_received(:get_chat_completion)
  end

  it "enqueues a TTS job" do
    subject.process!
    expect(GenerateInsultTtsJob).to have_received(:perform_async)
  end
end
