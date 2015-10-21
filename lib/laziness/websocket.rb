require 'eventmachine'
require 'faye/websocket'
require 'multi_json'

module Slack
  class Websocket
    attr_reader :session

    def initialize(session)
      @session = session
    end

    def run(queue=nil, options={})
      EM.run do
        connect(options)

        connection.on(:open) { }
        connection.on(:message) { |event|  }
        connection.on(:close) { shutdown }
        connection.on(:error) { |event|  }

        queue << connection if queue
      end
    end

    def shutdown
      connection.close if connection
      EM.stop if EM.reactor_running?
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
