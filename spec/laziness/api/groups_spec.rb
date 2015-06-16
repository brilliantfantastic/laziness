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
end
