require_relative "../../rails_helper"

RSpec.describe "Update Voice Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation UpdateVoice($input: UpdateVoiceInput!) {
        updateVoice(input: $input) {
          voice {
            id
            name
            xiVoiceId
            xiSimilarityBoost
            xiStability
            xiStyle
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:voice) { create(:voice) }

  let(:variables) do
    {
      input: {
        id: voice.id,
        name: "updated name",
        xiVoiceId: "abc12345",
        xiSimilarityBoost: 0.5,
        xiStability: 0.5,
        xiStyle: 0.4
      }
    }
  end
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "updates the voice" do
    result = subject
    # byebug
    expect(result["data"]["updateVoice"]["voice"]["name"]).to eq("updated name")
    expect(result["data"]["updateVoice"]["voice"]["xiVoiceId"]).to eq("abc12345")
    voice.reload
    expect(voice.name).to eq("updated name")
    expect(voice.xi_voice_id).to eq("abc12345")
  end
end
