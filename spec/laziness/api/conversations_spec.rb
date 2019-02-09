describe Slack::API::Conversations do
  let(:access_token) { "12345" }
  subject { Slack::API::Conversations.new access_token }

  describe '.all' do
    it 'returns all the channels for a team' do
      stub_slack_request :get,
        "conversations.list?token=#{access_token}&exclude_archived=0&"\
        "types=public_channel",
        "conversations_list.json"

      conversations = subject.all
      expect(conversations.length).to eq 1
      expect(conversations[0].id).to eq "C02BLAH"
    end
  end

  describe '.find' do
    it 'returns the specific channel with the specified id' do
      stub_slack_request :get,
        "conversations.info?channel=C02BLAH&token=#{access_token}",
        'conversations_info.json'

      conversation = subject.find("C02BLAH")
      expect(conversation.id).to eq "C02BLAH"
      expect(conversation.name).to eq "tour"
    end
  end
end
