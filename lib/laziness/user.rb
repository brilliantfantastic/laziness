require 'hashie'

module Slack
  class User < Hashie::Mash
    class << self
      def parse(request)
        new JSON.parse(request)
      end
    end
  end
end
