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
  end

  describe ".open" do
  end
end
