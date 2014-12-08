module Slack
  module API
    class Channels < Base
      def all
        response = request :get, access_token, 'channels.list'
        Slack::Channel.parse response, 'channels'
      end
    end
  end
end
