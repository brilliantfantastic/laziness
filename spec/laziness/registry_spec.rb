describe Slack::Registry do
  describe "#register" do
    it "registers the handler with a block" do
      expect { subject.register :topic do end }.to \
        change { subject.observers.count }.by 1
    end

    it "registers the handler with an object and method" do
      expect { subject.register :topic, self, :blah }.to \
        change { subject.observers.count }.by 1
    end
  end

  describe "#unregister" do
    it "unregisters the handler with the same block signature" do
      blk = -> { }
      subject.register blk
      expect { subject.unregister blk }.to \
        change { subject.observers.count }.by -1
    end
  end

  describe "#notify" do
    it "calls the observers that match the topics" do
      topic1_called = false
      topic2_called = false
      subject.register :topic1 do topic1_called = true end
      subject.register :topic2 do topic2_called = true end
      subject.notify :topic1
      expect(topic1_called).to be_truthy
      expect(topic2_called).to be_falsey
    end
  end
end
