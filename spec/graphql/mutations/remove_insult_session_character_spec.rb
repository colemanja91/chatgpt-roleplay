require_relative "../../rails_helper"

RSpec.describe "Remove Character From Insult Session Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation RemoveInsultSessionCharacter($input: RemoveInsultSessionCharacterInput!) {
        removeInsultSessionCharacter(input: $input) {
          insultSession {
            id
            startedAt
            characters {
              description
              voice { 
                id
              }
            }
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:character) { create(:insult_session_character) }

  let(:variables) { {input: {characterId: character.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "removes the character" do
    expect { subject }.to change { InsultSessionCharacter.count }.by(-1)
  end
end
