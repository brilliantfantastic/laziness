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
  end

  describe "#on" do
    it "registers an event handler" do
      expect_any_instance_of(Slack::Registry).to \
        receive(:register).with(:message, nil, :update).and_call_original
      subject.on :message
    end
  end

  describe "#off" do
    it "unregisters an event" do
      expect_any_instance_of(Slack::Registry).to \
        receive(:unregister).with(:open, nil, :update).and_call_original
      subject.off :open
    end
  end

  describe "#send_message"

  describe "#shutdown" do
    it "stops the event loop" do
      expect(EM).to receive(:stop).at_least(:once).and_call_original
      with_websocket(subject, queue) do
        subject.shutdown
      end
    end
  end
end
