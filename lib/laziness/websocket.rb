require 'eventmachine'
require 'faye/websocket'

module Slack
  class Websocket
    attr_reader :session

    def initialize(session)
      @session = session
      @events = Registry.new
    end

    def broadcast(channel, message, options={})
      EM.defer do
        attributes = { channel: channel, text: message }.merge(options)
        connection.send Message.generate(attributes).to_json
      end
    end

    def run(queue=nil, options={})
      EM.run do
        connect(options)

        connection.on(:open) { |event| EM.defer { @events.notify(:open, event) }}
        connection.on(:message) { |event| send_message(event) }
        connection.on(:close) do |event|
          EM.defer { @events.notify(:close, event) }
          shutdown
        end
        connection.on(:error) { |event| EM.defer { @events.notify(:error, event) }}

        queue << connection if queue
      end
    end

    def on(event=nil, handler=nil, func=:update, &blk)
      @events.register event, handler, func, &blk
      self
    end

    def off(event=nil, handler=nil, func=:update, &blk)
      @events.unregister event, handler, func, &blk
    end

    def shutdown
      connection.close if connection
      EM.stop if EM.reactor_running?
      @events.clear
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

    def send_message(event)
      message = Message.parse event.data
      EM.defer { @events.notify(message.type, message) }
    end
  end
end
