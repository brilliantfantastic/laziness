describe Slack::Observer do
  describe "#execute" do
    it "calls the block" do
      executed = false
      observer = Slack::Observer.new do
        executed = true
      end.execute
      expect(executed).to be_truthy
    end

    it "calls the method on the observer" do
      @executed = false
      def blah
        @executed = true
      end
      observer = Slack::Observer.new nil, self, :blah
      observer.execute
      expect(@executed).to be_truthy
    end
  end

  describe "#==" do
    let(:blk) { -> { puts "blah" } }
    let(:topic) { :topic }

    it "is equal if the objects have the same topic and blocks" do
      left = Slack::Observer.new topic, &blk
      right = Slack::Observer.new topic, &blk
      expect(left).to eq right
    end

    it "is equal if the objects have the same topic and observers" do
      left = Slack::Observer.new topic, self
      right = Slack::Observer.new topic, self
      expect(left).to eq right
    end

    it "is not equal if the topics are different" do
      left = Slack::Observer.new topic, &blk
      right = Slack::Observer.new :blah, &blk
      expect(left).to_not eq right
    end

    it "is not equal if the blocks are different" do
      other_blk = -> { puts "blah" }
      left = Slack::Observer.new topic, &blk
      right = Slack::Observer.new topic, &other_blk
      expect(left).to_not eq right
    end

    it "is not equal if the observer methods are different" do
      left = Slack::Observer.new topic, self, :blah
      right = Slack::Observer.new topic, self, :bleh
      expect(left).to_not eq right
    end
  end
end
