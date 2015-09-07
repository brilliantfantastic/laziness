describe Slack::API::OAuth do
  subject { Slack::API::OAuth.new }

  describe '.access' do
    let(:client_id) { "1234" }
    let(:client_secret) { "5678" }
    let(:code) { "9012" }

    it 'exchanges a temporary oauth code for an API access token' do
      stub_slack_request :get, "oauth.access?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}", 'oauth_access.json'

      oauth = subject.access client_id, client_secret, code
      expect(oauth.ok).to eq true
    end
  end
end
