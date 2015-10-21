describe Slack::API::RTM do
  let(:access_token) { "12345" }
  subject { Slack::API::RTM.new access_token }

  describe '.start' do
    it 'returns the rtm session' do
      stub_slack_request :get, "rtm.start?token=#{access_token}", 'rtm_start.json'
      session = subject.start
      expect(session.url).to eq 'wss://example.com'
    end
  end
end
