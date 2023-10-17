require_relative "../../rails_helper"

RSpec.describe "Update Character Mutation" do
  let!(:voice) { create(:voice) }

  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation UpdateCharacter($input: UpdateCharacterInput!) {
        updateCharacter(input: $input) {
          character {
            id
            name
            systemMessage
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:character) { create(:character) }

  let(:variables) do
    {
      input: {
        id: character.id,
        name: "updated name",
        systemMessage: "updated system message",
        ttsEnabled: true,
        voiceId: voice.id,
        contextSize: 16000,
        variableTemperatureEnabled: true,
        avatarUrl: "foo"
      }
    }
  end
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "updates the character" do
    result = subject

    expect(result["data"]["updateCharacter"]["character"]["name"]).to eq("updated name")
    expect(result["data"]["updateCharacter"]["character"]["systemMessage"]).to eq("updated system message")
    character.reload
    expect(character.name).to eq("updated name")
    expect(character.system_message).to eq("updated system message")
  end
end
