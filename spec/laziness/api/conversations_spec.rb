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

  describe '.invite' do
    it 'invites users to a channel and returns the specified channel' do
      stub_slack_request :post,
        "conversations.invite?channel=tour&"\
        "users=U024BLAH,U025BLAH&token=#{access_token}",
        'conversations_info.json'

      conversation = subject.invite("tour", ["U024BLAH", "U025BLAH"])
      expect(conversation.id).to eq "C02BLAH"
      expect(conversation.name).to eq "tour"
    end
  end

  describe '.join' do
    it 'joins the current user to the specific channel' do
      stub_slack_request :post,
        "conversations.join?channel=C02BLAH&token=#{access_token}",
        'conversations_info.json'

      conversation = subject.join("C02BLAH")
      expect(conversation.id).to eq "C02BLAH"
      expect(conversation.name).to eq "tour"
    end
  end

  describe '.kick' do
    it 'removes a user from a channel' do
      stub = stub_slack_request :post,
        "conversations.kick?channel=G01BLAH&user=U024BLAH&token=#{access_token}",
        'successful_response.json'

      expect(subject.kick("G01BLAH", "U024BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.leave' do
    it 'removes the current user from a channel' do
      stub = stub_slack_request :post,
        "conversations.leave?channel=G01BLAH&token=#{access_token}",
        'successful_response.json'

      expect(subject.leave("G01BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.members' do
    it 'returns all the users from a channel' do
      stub = stub_slack_request :get,
        "conversations.members?channel=C02BLAH&token=#{access_token}",
        'conversations_members.json'

      members = subject.members("C02BLAH")
      expect(members).to eq ["U024BLAH", "U024BLAH2"]
    end
  end

  describe '.open' do
    it 'opens a direct message channel' do
      stub_slack_request :post,
        "conversations.open?return_im=false&users=U024BLAH,U025BLAH&token=#{access_token}",
        'conversations_info.json'

      conversation = subject.open(["U024BLAH", "U025BLAH"])
      expect(conversation.id).to eq "C02BLAH"
    end
  end

  describe '.rename' do
    it 'renames the channel' do
      stub_slack_request :post,
        "conversations.rename?channel=C02BLAH&name=tour&token=#{access_token}",
        'conversations_info.json'

      conversation = subject.rename("C02BLAH", "tour")
      expect(conversation.id).to eq "C02BLAH"
      expect(conversation.name).to eq "tour"
    end
  end

  describe '.unarchive' do
    it 'marks the channel as unarchived' do
      stub = stub_slack_request :post,
        "conversations.unarchive?channel=C02BLAH&token=#{access_token}",
        'successful_response.json'

      expect(subject.unarchive("C02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end
end
