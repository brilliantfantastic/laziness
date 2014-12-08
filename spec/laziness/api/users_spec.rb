describe Slack::API::Users do
  let(:access_token) { "12345" }
  subject { Slack::API::Users.new access_token }

  describe '.all' do
    it 'returns all the users for an account' do
      stub_slack_request :get, "users.list?token=#{access_token}", 'users_list.json'

      users = subject.all
      expect(users.length).to eq 2
      expect(users[0].id).to eq "U024BLAH"
      expect(users[1].id).to eq "U024BLAH2"
    end
  end

  describe '.find' do
    it 'returns the specific user with the specified id' do
      stub_slack_request :get, "users.info?user=U024BLAH&token=#{access_token}", 'users_info.json'

      user = subject.find("U024BLAH")
      expect(user.id).to eq "U024BLAH"
      expect(user.name).to eq "jimmy"
    end
  end

  describe '.set_active' do
    it 'marks the user as active' do
      stub = stub_slack_request :post, "users.setActive?token=#{access_token}", 'successful_response.json'

      expect(subject.set_active).to be_nil
      expect(stub).to have_been_requested
    end
  end
end
