require_relative "../../rails_helper"

RSpec.describe "Insult Session Query" do
  let!(:session) { create(:started_session) }

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
        }
      }
    GRAPHQL

    querystring
  end

  let(:subject) { ChatgptRoleplaySchema.execute(query) }

  it "returns the session" do
    result = subject
    expect(result["data"]["insultSession"]["id"]).to eq(session.id.to_s)
  end
end
