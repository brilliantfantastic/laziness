require "securerandom"

module Slack
  class Message < Base
    def initialize(attributes)
      super
      symbolize_type attributes[:type]
    end

    class << self
      def generate(attributes)
        new({ id: generate_id, type: :message }.merge attributes)
      end

      def generate_id
        SecureRandom.random_number(9999999).to_s
      end

      def parse(message)
        request = Request.new message
        base = Base.parse request
        new base
      end
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
