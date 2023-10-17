require_relative "../../rails_helper"

RSpec.describe "Add Character to Insult Session Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation AddCharacterToInsultSession($input: AddCharacterToInsultSessionInput!) {
        addCharacterToInsultSession(input: $input) {
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

  let!(:session) { create(:started_session) }

  let(:voice) { create(:voice) }
  let(:variables) { {input: {id: session.id, description: "yo this is a character", voiceId: voice.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "adds a character" do
    expect { subject }.to change { session.reload.insult_session_characters.count }.by(1)
  end

  it "starts the session" do
    result = subject
    expect(result["data"]["addCharacterToInsultSession"]["insultSession"]["characters"][0]["description"]).to eq("yo this is a character")
    expect(result["data"]["addCharacterToInsultSession"]["insultSession"]["characters"][0]["voice"]["id"]).to eq(voice.id.to_s)
  end
end
