require_relative "../../rails_helper"

RSpec.describe "End Insult Session Mutation" do
  let(:mutation) do
    querystring = <<-GRAPHQL
      mutation EndInsultSession($input: EndInsultSessionInput!) {
        endInsultSession(input: $input) {
          insultSession {
            id
            startedAt
            endedAt
          }
        }
      }
    GRAPHQL

    querystring
  end

  let!(:session) { create(:insult_session) }

  let(:variables) { {input: {id: session.id}} }
  let(:subject) { ChatgptRoleplaySchema.execute(mutation, variables: variables) }

  it "ends the session" do
    expect(session.ended_at).to be_nil
    subject
    expect(session.reload.ended_at).not_to be_nil
  end
end
