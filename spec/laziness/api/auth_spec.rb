describe Slack::API::Auth do
  let(:access_token) { "12345" }
  subject { Slack::API::Auth.new access_token }

  describe '.test' do
    it 'returns the status of the authentication token' do
      stub_slack_request :get, "auth.test?token=#{access_token}", 'auth_test.json'

      auth = subject.test
      expect(auth.ok).to eq true
    end
  end
end
