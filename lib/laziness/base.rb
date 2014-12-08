require 'hashie'

module Slack
  class Base < Hashie::Mash
    class << self
      def parse(request, key=nil)
        parsed = JSON.parse(request)
        parsed = parsed[key] if key && parsed[key]
        if parsed.is_a? Array
          models = []
          parsed.each { |attributes| models << new(attributes) }
          models
        else
          new parsed
        end
      end
    end
  end
end
