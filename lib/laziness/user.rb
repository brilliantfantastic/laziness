require 'hashie'

module Slack
  class User < Hashie::Mash
    class << self
      def parse(request, key=nil)
        parsed = JSON.parse(request)
        parsed = parsed[key] if key && parsed[key]
        if parsed.is_a? Enumerable
          users = []
          parsed.each { |user| users << new(user) }
          users
        else
          new parsed
        end
      end
    end
  end
end
