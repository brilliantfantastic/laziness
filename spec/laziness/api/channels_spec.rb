describe Slack::API:: Channels do
  let(:access_token) { "12345" }
  subject { Slack::API::Channels.new access_token }

  describe '.all' do
    it 'returns all the channels for an account' do
      response = {
        ok: true,
        channels: [
          {
            id: "C02BLAH",
            name: "tour",
            is_channel: true,
            created: 1403798029,
            creator: "U024BLAH",
            is_archived: false,
            is_general: false,
            is_member: true,
            members: [
                "U024BLAH",
                "U024BLAH2"
            ],
            topic: {
                value: "",
                creator: "",
                last_set: 0
            },
            purpose: {
                value: "A place to discuss the upcoming tour",
                creator: "U024BLAH",
                last_set: 1403798029
            },
            num_members: 2
          }
        ]
      }
      stub_request(:get, "https://slack.com/api/channels.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
      channels = subject.all
      expect(channels.length).to eq 1
      expect(channels[0].id).to eq "C02BLAH"
    end
  end
end
