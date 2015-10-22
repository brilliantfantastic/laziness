module Slack
  class Observer
    attr_accessor :topic
    attr_reader :observer, :func, :blk

    def initialize(topic=nil, observer=nil, func=:update, &blk)
      @topic = topic
      @observer = observer
      @func = func
      @blk = blk
    end

    def execute
      blk.call if blk
      observer.send func if observer && observer.respond_to?(func)
    end

    def ==(other)
      return false if other.nil?
      self.topic == other.topic && self.blk == other.blk &&
        self.observer == other.observer && self.func == other.func
    end
  end
end
