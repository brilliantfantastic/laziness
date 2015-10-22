module Slack
  class Registry
    attr_reader :observers

    def initialize
      @observers = []
    end

    def clear
      observers.clear
    end

    def notify(topic)
      observers.select { |o| o.topic == topic }.map(&:execute)
    end

    def register(topic=nil, observer=nil, func=:update, &blk)
      observers << Observer.new(topic, observer, func, &blk)
    end

    def unregister(topic=nil, observer=nil, func=:update, &blk)
      observers.delete Observer.new(topic, observer, func, &blk)
    end
  end
end
