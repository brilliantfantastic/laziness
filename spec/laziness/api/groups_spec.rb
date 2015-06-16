describe Slack::API::Groups do
  let(:access_token) { "12345" }
  subject { Slack::API::Groups.new access_token }

  describe '.all' do
    it 'returns all the groups for an account' do
      stub_slack_request :get, "groups.list?exclude_archived=0&token=#{access_token}", 'groups_list.json'

      groups = subject.all
      expect(groups.length).to eq 1
      expect(groups[0].id).to eq "G02BLAH"
    end
  end

  describe '.archive' do
    it 'marks the group as archived' do
      stub = stub_slack_request :post, "groups.archive?channel=G02BLAH&token=#{access_token}", 'successful_response.json'

      expect(subject.archive("G02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.close' do
    it 'closes the group' do
      stub = stub_slack_request :post, "groups.close?channel=G02BLAH&token=#{access_token}", 'successful_response.json'

      expect(subject.close("G02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.copy' do
    it 'creates a new group, archives the existing group, and returns the new group' do
      stub_slack_request :post, "groups.createChild?channel=G02BLAH&token=#{access_token}", 'groups_info.json'

      group = subject.copy("G02BLAH")
      expect(group.id).to eq "G02BLAH"
      expect(group.name).to eq "music"
    end
  end

  describe '.create' do
    it 'creates a new group and returns the specified group' do
      stub_slack_request :post, "groups.create?name=music&token=#{access_token}", 'groups_info.json'

      group = subject.create("music")
      expect(group.id).to eq "G02BLAH"
      expect(group.name).to eq "music"
    end
  end

  describe '.find' do
    it 'returns the specific group with the specified id' do
      stub_slack_request :get, "groups.info?channel=G02BLAH&token=#{access_token}", 'groups_info.json'

      group = subject.find("G02BLAH")
      expect(group.id).to eq "G02BLAH"
      expect(group.name).to eq "music"
    end
  end

  describe '.invite' do
    it 'returns the specific group with the specified id' do
      stub_slack_request :post, "groups.invite?channel=G02BLAH&user=U024BLAH&token=#{access_token}", 'groups_info.json'

      group = subject.invite("G02BLAH", "U024BLAH")
      expect(group.id).to eq "G02BLAH"
      expect(group.name).to eq "music"
    end
  end

  describe '.kick' do
    it 'removes the specified user from the specified group' do
      stub = stub_slack_request :post, "groups.kick?channel=G02BLAH&user=U024BLAH&token=#{access_token}", 'successful_response.json'

      expect(subject.kick("G02BLAH", "U024BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.leave' do
    it 'removes the current user from the specified group' do
      stub = stub_slack_request :post, "groups.leave?channel=G02BLAH&token=#{access_token}", 'successful_response.json'

      expect(subject.leave("G02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.open' do
    it 'opens the group' do
      stub = stub_slack_request :post, "groups.open?channel=G02BLAH&token=#{access_token}", 'successful_response.json'

      expect(subject.open("G02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.unarchive' do
    it 'marks the group as unarchived' do
      stub = stub_slack_request :post, "groups.unarchive?channel=G02BLAH&token=#{access_token}", 'successful_response.json'

      expect(subject.unarchive("G02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end
end
