require_relative "../../rails_helper"

RSpec.describe "Add Death to Insult Session Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation AddDeathToInsultSession($input: AddDeathToInsultSessionInput!) {
        addDeathToInsultSession(input: $input) {
          insultSession {
            id
            startedAt
            deathCounter
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:session) { create(:insult_session) }

  let(:variables) { {input: {id: session.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  before do
    allow(InsultChatJob).to receive(:perform_async).with(session.id).and_call_original
  end

  it "starts the session" do
    expect(session.death_counter).to eq(0)
    result = subject
    expect(session.reload.death_counter).to eq(1)
    expect(InsultChatJob).to have_received(:perform_async).with(session.id)
    expect(result["data"]["addDeathToInsultSession"]["insultSession"]["deathCounter"]).to eq(1)
  end
end
