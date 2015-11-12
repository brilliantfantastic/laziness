describe Slack::API::Chat do
  let(:access_token) { "12345" }
  subject { Slack::API::Chat.new access_token }

  describe '.create' do
    it 'creates a new chat message and returns the specified message' do
      stub_slack_request :post, "chat.postMessage?channel=C02BLAH&text=Hello%20world&username=bot_user&as_user=false&token=#{access_token}", 'chat_post_message.json'

      message = subject.create("Hello world", "C02BLAH", username: "bot_user", as_user: false)
      expect(message.text).to eq "Hello world"
      expect(message.username).to eq "bot_user"
    end
  end

  describe '.delete' do
    it 'deletes a chat message' do
      stub = stub_slack_request :post, "chat.delete?channel=C02BLAH&ts=1447299140.000002&token=#{access_token}", 'chat_delete.json'

      expect(subject.delete("C02BLAH", "1447299140.000002")).to be_nil
      expect(stub).to have_been_requested
    end
  end

  describe '.update' do
    it 'updates a chat message and returns the updated message' do
      stub_slack_request :post, "chat.update?channel=C02BLAH&ts=1447299140.000002&text=Hello%20again&token=#{access_token}", 'chat_update.json'

      message = subject.update("Hello again", "C02BLAH", "1447299140.000002")
      expect(message.text).to eq "Hello again"
      expect(message.ts).to eq "1447299140.000002"
    end
  end
end
