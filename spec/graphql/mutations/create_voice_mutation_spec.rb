require_relative "../../rails_helper"

RSpec.describe "Create Voice Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation CreateVoice($input: CreateVoiceInput!) {
        createVoice(input: $input) {
          voice {
            id
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

  let(:variables) do
    {
      input: {
        name: "test name",
        xiVoiceId: "abc12345",
        xiSimilarityBoost: 0.5,
        xiStability: 0.5,
        xiStyle: 0.4
      }
    }
  end
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "creates the voice" do
    expect { subject }.to change { Voice.count }.by(1)
  end
end
