require_relative "../rails_helper"

RSpec.describe InsultCronService do
  let(:subject) { described_class.new }

  let(:openai_service) { instance_double(OpenaiService) }

  before do
    allow(InsultChatJob).to receive(:perform_async).and_call_original
  end

  context "no sessions" do
    it "does not error" do
      expect { subject.run! }.not_to raise_error
    end
  end

  context "session without messages" do
    let!(:session) { create(:started_session) }

    it "does not enqueue a job" do
      subject.run!
      expect(InsultChatJob).not_to have_received(:perform_async)
    end
  end

  context "session with messages" do
    let!(:session) { create(:started_session) }
    let!(:character) { create(:insult_session_character, insult_session: session) }
    let!(:message) { create(:insult_session_message, insult_session: session, insult_session_character: character, created_at: created_at) }

    context "last message was > 6min ago" do
      let(:created_at) { 7.minutes.ago }

      it "enqueues a job" do
        subject.run!
        expect(InsultChatJob).to have_received(:perform_async).with(session.id)
      end
    end

    context "last message was < 3 min ago" do
      let(:created_at) { 2.minutes.ago }

      it "does not enqueue a job" do
        subject.run!
        expect(InsultChatJob).not_to have_received(:perform_async)
      end
    end

    context "last message was 3 - 6 min ago" do
      let(:created_at) { 4.minutes.ago }

      before do
        allow_any_instance_of(Array).to receive(:sample).and_return(choiche)
      end

      context "random choiche is false" do
        let(:choiche) { false }

        it "does not enqueue a job" do
          subject.run!
          expect(InsultChatJob).not_to have_received(:perform_async)
        end
      end

      context "random choiche is true" do
        let(:choiche) { true }

        it "enqueues a job" do
          subject.run!
          expect(InsultChatJob).to have_received(:perform_async).with(session.id)
        end
      end
    end
  end
end
