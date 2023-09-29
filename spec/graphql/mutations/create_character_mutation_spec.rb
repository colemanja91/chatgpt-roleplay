require_relative "../../rails_helper"

RSpec.describe "Create Character Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation CreateCharacter($input: CreateCharacterInput!) {
        createCharacter(input: $input) {
          character {
            id
          }
        }
      }
    GRAPHQL

    querystring
  end

  let(:variables) { {input: {name: "test name", systemMessage: "test system message", ttsEnabled: true}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "creates the character" do
    expect { subject }.to change { Character.count }.by(1)
  end
end
