require_relative "../../rails_helper"

RSpec.describe "Delete Character Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation DeleteCharacter($input: DeleteCharacterInput!) {
        deleteCharacter(input: $input) {
          status
        }
      }
    GRAPHQL

    querystring
  end

  let!(:character) { create(:character) }

  let(:variables) { {input: {id: character.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "deletes the character" do
    expect { subject }.to change { Character.count }.by(-1)
  end
end
