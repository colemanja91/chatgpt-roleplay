require_relative "../../rails_helper"

RSpec.describe "Character Query" do
  describe "Find by ID" do
    let(:character) { create(:character) }
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
      expect(subject["data"]["character"]["id"].to_i).to eq(character.id)
    end

    it "returns the messages" do
      result = subject
      expect(subject["data"]["character"]["messages"][0]["id"].to_i).to eq(message.id)
    end
  end

  describe "List All" do
    let(:query) do
      querystring = <<-GRAPHQL
        query GetCharacters {
          characters {
            id
            name
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
