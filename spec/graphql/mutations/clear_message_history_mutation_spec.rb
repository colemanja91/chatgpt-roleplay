require_relative "../../rails_helper"

RSpec.describe "Clear Message History Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation ClearMessageHistory($input: ClearMessageHistoryInput!) {
        clearMessageHistory(input: $input) {
          character {
            id
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:character) { create(:character) }

  before do
    create(:user_message, character: character)
    create(:assistant_message, character: character)
    character_2 = create(:character, name: "other name")
    create(:user_message, character: character_2)
  end

  let(:variables) { {input: {characterId: character.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "deletes the character" do
    expect { subject }.to change { character.messages.count }.by(-2)
  end
end
