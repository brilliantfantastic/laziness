require 'eventmachine'
require 'faye/websocket'
require 'multi_json'

module Slack
  class Websocket
    attr_reader :session

    def initialize(session)
      @session = session
      @event_registry = Registry.new
    end

    def register_event_handler(event=nil, handler=nil, func=:update, &blk)
      @event_registry.register event, handler, func, &blk
    end

    def unregister_event_handler(event=nil, handler=nil, func=:update, &blk)
      @event_registry.unregister event, handler, func, &blk
    end

    def run(queue=nil, options={})
      EM.run do
        connect(options)

        connection.on(:open) { |event| @event_registry.notify(:open, event) }
        connection.on(:message) { |event|  }
        connection.on(:close) do |event|
          @event_registry.notify(:close, event)
          shutdown
        end
        connection.on(:error) { |event| @event_registry.notify(:error, event) }

        queue << connection if queue
      end
    end

    def shutdown
      connection.close if connection
      EM.stop if EM.reactor_running?
      @event_registry.clear
    end

    private

    attr_reader :connection

    def connect(options={})
      @connection ||=
        Faye::WebSocket::Client.new(session.url, nil, default_options.merge(options))
    end

    def default_options
      { ping: 10 }
    end
  end
end
