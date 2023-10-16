require_relative "../../rails_helper"

RSpec.describe "Character Query" do
  describe "Find by ID" do
    let(:voice) { create(:voice) }
    let(:character) { create(:character, voice: voice) }
    let!(:message) { create(:user_message, character: character) }

    let(:query) do
      querystring = <<-GRAPHQL
        query GetCharacter($id: ID!) {
          character(id: $id) {
            id
            name
            systemMessage
            systemMessageTokens
            createdAt
            updatedAt
            messages {
              id
              role
              content
              tokens
              ttsFilePath
            }
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

    let(:variables) { {id: character.id} }
    let(:subject) { ChatgptRoleplaySchema.execute(query, variables: variables) }

    it "returns the character" do
      result = subject
      expect(result["data"]["character"]["id"].to_i).to eq(character.id)
    end

    it "returns the messages" do
      result = subject
      expect(result["data"]["character"]["messages"][0]["id"].to_i).to eq(message.id)
    end
  end

  describe "List All" do
    let(:query) do
      querystring = <<-GRAPHQL
        query GetCharacters {
          characters {
            id
            name
            voice {
              id
            }
          }
        }
      GRAPHQL

      querystring
    end

    let(:subject) { ChatgptRoleplaySchema.execute(query) }

    before do
      3.times do |index|
        create(:character, name: "test character #{index}")
      end
    end

    it "returns all the characters" do
      result = subject
      expect(result["data"]["characters"].length).to eq(3)
    end
  end
end
