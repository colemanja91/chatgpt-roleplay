require_relative "../../rails_helper"

RSpec.describe "Insult Session Query" do
  let(:voice) { create(:voice) }
  let!(:session) { create(:started_session) }
  let!(:character) { create(:insult_session_character, insult_session: session, voice: voice) }
  let!(:message) { create(:insult_session_message, insult_session: session, insult_session_character: character, tts_file_path: "path/to/file") }

  let(:query) do
    querystring = <<-GRAPHQL
      query GetInsultSession {
        insultSession {
          id
          name
          game
          deathCounter
          startedAt
          endedAt
          characters {
            id
            description
            voice {
              id
            }
          }
          lastMessage {
            id
            content
            ttsFilePath
          }
        }
      }
    GRAPHQL

    querystring
  end

  let(:subject) { ChatgptRoleplaySchema.execute(query) }

  it "returns the session" do
    result = subject
    expect(result["data"]["insultSession"]["id"]).to eq(session.id.to_s)
    expect(result["data"]["insultSession"]["characters"][0]["id"]).to eq(character.id.to_s)
    expect(result["data"]["insultSession"]["characters"][0]["voice"]["id"]).to eq(character.voice.id.to_s)
    expect(result["data"]["insultSession"]["lastMessage"]["id"]).to eq(message.id.to_s)
  end
end
