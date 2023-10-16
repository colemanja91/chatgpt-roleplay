require_relative "../../rails_helper"

RSpec.describe "Delete Boice Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation DeleteVoice($input: DeleteVoiceInput!) {
        deleteVoice(input: $input) {
          status
        }
      }
    GRAPHQL

    querystring
  end

  let!(:voice) { create(:voice) }

  let(:variables) { {input: {id: voice.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "deletes the voice" do
    expect { subject }.to change { Voice.count }.by(-1)
  end
end
