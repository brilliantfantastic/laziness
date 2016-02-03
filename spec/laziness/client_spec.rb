describe Slack::Client do
  it "returns a new client" do
    expect(Slack.web_client(access_token: "blah")).to be_instance_of Slack::Client
  end

  it "assigns the access token" do
    expect(Slack.web_client(access_token: "blah").access_token).to eq "blah"
  end
end
