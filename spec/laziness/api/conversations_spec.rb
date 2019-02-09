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

  describe '.archive' do
    it 'marks the channel as archived' do
      stub = stub_slack_request :post,
        "conversations.archive?channel=C02BLAH&token=#{access_token}",
        'successful_response.json'

      expect(subject.archive("C02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.close' do
    it 'closes a direct message channel' do
      stub = stub_slack_request :post,
        "conversations.close?channel=G01BLAH&token=#{access_token}",
        'successful_response.json'

      expect(subject.close("G01BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.create' do
    it 'creates a new channel and returns the specified channel' do
      stub_slack_request :post,
        "conversations.create?name=tour&is_private=false&"\
        "user_ids=[]&token=#{access_token}",
        'conversations_info.json'

      conversation = subject.create("tour")
      expect(conversation.id).to eq "C02BLAH"
      expect(conversation.name).to eq "tour"
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