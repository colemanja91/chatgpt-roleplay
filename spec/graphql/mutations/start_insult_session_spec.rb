require_relative "../../rails_helper"

RSpec.describe "Start Insult Session Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation StartInsultSession($input: StartInsultSessionInput!) {
        startInsultSession(input: $input) {
          insultSession {
            id
            startedAt
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:session) { create(:insult_session) }

  let(:variables) { {input: {id: session.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "starts the session" do
    expect(session.started_at).to be_nil
    subject
    expect(session.reload.started_at).not_to be_nil
  end
end
