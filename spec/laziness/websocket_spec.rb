describe Slack::Websocket do
  let(:session) { double(:session, url: "wss://example.com") }
  let(:queue) { Queue.new }
  subject { Slack::Websocket.new(session) }

  def with_websocket(subject, queue)
    thread = Thread.new { subject.run(queue, ping: nil) }
    thread.abort_on_exception = true
    yield queue.pop if block_given?
    subject.shutdown
    thread.join
  end

  it "accepts a session" do
    session = double(:session)
    expect(Slack::Websocket.new(session).session).to eq session
  end

  describe "#run" do
    it "creates the websocket on the queue" do
      with_websocket(subject, queue) do |ws|
        expect(ws).to be_an_instance_of Faye::WebSocket::Client
      end
    end

    it "notifies a close event" do
      notified = false
      subject.register_event_handler :close do
        notified = true
      end
      with_websocket(subject, queue) do |ws|
        ws.close
        expect(notified).to be_truthy
      end
    end
  end

  describe "#message_received"
  describe "#send_message"
  describe "#shutdown"
end
