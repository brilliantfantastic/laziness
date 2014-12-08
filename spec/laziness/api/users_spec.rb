describe Slack::API::Users do
  let(:access_token) { "12345" }
  subject { Slack::API::Users.new access_token }

  describe '.all' do
    it 'returns all the users for an account' do
      response = {
        ok: true,
        members: [
          {
            id: "U024BLAH",
            name: "jimmy",
            deleted: false,
            status: nil,
            real_name: "Jimmy Page"
          },
          {
            id: "U024BLAH2",
            name: "robert",
            deleted: false,
            status: nil,
            real_name: "Robert Plant"
          }
        ]
      }
      stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
      users = subject.all
      expect(users.length).to eq 2
      expect(users[0].id).to eq "U024BLAH"
      expect(users[1].id).to eq "U024BLAH2"
    end
  end

  describe '.find' do
    it 'returns the specific user with the specified id' do
      response  = {
        ok: true,
        user: {
          id: "U024BLAH",
          name: "jimmy",
          deleted: false,
          status: nil,
          real_name: "Jimmy Page"
        }
      }
      stub_request(:get, "https://slack.com/api/users.info?token=#{access_token}&user=U024BLAH").
        to_return(status: 200, body: response.to_json)
      user = subject.find("U024BLAH")
      expect(user.id).to eq "U024BLAH"
      expect(user.name).to eq "jimmy"
    end
  end

  describe '.set_active' do
    it 'marks the user as active' do
      response = { ok: true }
      stub = stub_request(:post, "https://slack.com/api/users.setActive?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
      expect(subject.set_active).to be_nil
      expect(stub).to have_been_requested
    end
  end
end
