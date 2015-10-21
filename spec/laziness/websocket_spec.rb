describe Slack::Websocket do
  let(:session) { double(:session, url: "wss://example.com") }
  let(:queue) { Queue.new }
  subject { Slack::Websocket.new(session) }

  def with_websocket(subject, queue)
    thread = Thread.new { subject.run(queue, ping: nil) }
    thread.abort_on_exception = true
    yield queue.pop
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

    xit "notifies a connect"
    xit "notifies a disconnect"
    xit "notifies an error"
  end

  describe "#message_received"
  describe "#send_message"
  describe "#shutdown"
end
