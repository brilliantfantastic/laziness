describe Slack::Message do
  describe "#parse" do
    it "initializes a new message with a JSON string" do
      message = Slack::Message.parse '{ "id": "1234", "type": "blah" }'
      expect(message).to be_a Slack::Message
      expect(message.id).to eq "1234"
      expect(message.type).to eq :blah
    end
  end

  describe "#generate" do
    it "generates a new message with a random id and type" do
      message = Slack::Message.generate text: "This is a test"
      expect(message.id).to_not be_empty
      expect(message.type).to eq :message
      expect(message.text).to eq "This is a test"
    end

    it "can have an id specified" do
      expect(Slack::Message).to_not receive(:generate_id)
      message = Slack::Message.generate id: 12345
      expect(message.id).to eq 12345
    end
  end
end
