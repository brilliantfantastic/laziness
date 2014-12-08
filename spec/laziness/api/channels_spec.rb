describe Slack::API:: Channels do
  let(:access_token) { "12345" }
  subject { Slack::API::Channels.new access_token }

  describe '.all' do
    it 'returns all the channels for an account' do
      stub_slack_request :get, "channels.list?exclude_archived=0&token=#{access_token}", 'channels_list.json'

      channels = subject.all
      expect(channels.length).to eq 1
      expect(channels[0].id).to eq "C02BLAH"
    end
  end
end
