require_relative "../rails_helper"

RSpec.describe InsultSession do
  describe "safeguard!" do
    let(:started_at) { nil }
    let(:ended_at) { nil }
    let(:session) { create(:insult_session, started_at: started_at, ended_at: ended_at) }

    context "not started" do
      it "returns false, does not change ended_at" do
        expect(session.ended_at).to be_nil
        result = session.safeguard!
        expect(result).to be(false)
        expect(session.reload.ended_at).to be_nil
      end
    end

    context "ended" do
      let(:started_at) { 3.minutes.ago }
      let(:ended_at) { Time.now }

      it "returns false, does not change ended_at" do
        result = session.safeguard!
        expect(result).to be(false)
        expect(session.reload.ended_at).to eq(ended_at)
      end
    end

    context "started, not ended" do
      context "started less than 3 hours ago" do
        let(:started_at) { 179.minutes.ago }

        it "returns false, does not change ended_at" do
          result = session.safeguard!
          expect(result).to be_nil
          expect(session.reload.ended_at).to be_nil
        end
      end

      context "started > 3 hours ago" do
        let(:started_at) { 181.minutes.ago }

        it "returns true, sets ended_at" do
          result = session.safeguard!
          expect(result).to be(true)
          expect(session.reload.ended_at).not_to be_nil
        end
      end
    end
  end
end
