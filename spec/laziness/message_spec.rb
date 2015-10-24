describe Slack::Message do
  describe "#parse" do
    it "initializes a new message with a JSON string" do
      message = Slack::Message.parse '{ "id": "1234", "type": "blah" }'
      expect(message).to be_a Slack::Message
      expect(message.id).to eq "1234"
      expect(message.type).to eq :blah
    end
  end
end
