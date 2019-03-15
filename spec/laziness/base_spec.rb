describe Slack::Base do
  describe "#parse_all" do
    let(:responses) do
      [
        double(:response,
               body: '{ "ok": true, "messages": [{ "id": "1234", "type": "blah" }] }'),
        double(:response,
               body: '{ "ok": true, "messages": [{ "id": "4567", "type": "bleh" }] }')
      ]
    end

    it "parses all of the messages in an array" do
      result = described_class.parse_all responses, 'messages'

      expect(result.count).to eq 2
      expect(result.first.id).to eq "1234"
      expect(result.last.id).to eq "4567"
    end
  end
end
