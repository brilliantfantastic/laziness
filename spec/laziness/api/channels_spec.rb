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

  describe '.find' do
    it 'returns the specific channel with the specified id' do
      stub_slack_request :get, "channels.info?channel=C02BLAH&token=#{access_token}", 'channels_info.json'

      channel = subject.find("C02BLAH")
      expect(channel.id).to eq "C02BLAH"
      expect(channel.name).to eq "tour"
    end
  end

  describe '.archive' do
    it 'marks the channel as archived' do
      stub = stub_slack_request :post, "channels.archive?channel=C02BLAH&token=#{access_token}", 'successful_response.json'

      expect(subject.archive("C02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end
end
