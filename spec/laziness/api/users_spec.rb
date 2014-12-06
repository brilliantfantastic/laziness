describe Slack::API::Users do
  let(:access_token) { "12345" }
  subject { Slack::API::Users.new access_token }

  describe '.all' do
    it 'returns all the users for an account' do
      response = {
        ok: true,
        messages: [
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
    end
  end
end
