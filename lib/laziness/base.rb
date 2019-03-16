require 'hashie'

module Slack
  class Base < Hashie::Mash
    class << self
      def parse(response, key=nil)
        parsed = JSON.parse(response.body)
        parsed = parsed[key] if key && parsed[key]
        if parsed.is_a? Array
          models = []
          parsed.each { |attributes| models << new(attributes) }
          models
        else
          new parsed
        end
      end

      def parse_all(responses, key=nil)
        responses.map do |response|
          parse(response, key)
        end.flatten
      end
    end
  end
end
