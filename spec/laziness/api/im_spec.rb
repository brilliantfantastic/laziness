describe Slack::API::IM do
  let(:access_token) { "12345" }
  subject { Slack::API::IM.new access_token }

  describe ".close" do
    it "closes a direct message channel" do
      stub = stub_slack_request :post, "im.close?channel=D02BLAH&token=#{access_token}", "im_close.json"
      expect(subject.close("D02BLAH")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe ".history" do
  end

  describe ".list" do
  end

  describe ".mark" do
    it "moves the read cursor to the specified timestamp in a direct message channel" do
      stub = stub_slack_request :post, "im.mark?channel=D02BLAH&ts=1234567890.123456&token=#{access_token}", "im_mark.json"
      expect(subject.mark("D02BLAH", "1234567890.123456")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe ".open" do
    it "opens a direct message channel and returns the channel information" do
      stub = stub_slack_request :post, "im.open?user=D024BLAH&token=#{access_token}", "im_open.json"
      channel = subject.open("D024BLAH")
      expect(channel.id).to eq "D02BLAH"
    end
  end
end
