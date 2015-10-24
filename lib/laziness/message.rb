module Slack
  class Message < Base
    def initialize(attributes)
      super
      symbolize_type attributes.type
    end

    def self.parse(message)
      request = Request.new message
      base = Base.parse request
      new base
    end

    private

    def symbolize_type(type)
      self.type = type.to_sym if type
    end

    class Request
      attr_reader :body

      def initialize(body)
        @body = body
      end
    end
  end
end
