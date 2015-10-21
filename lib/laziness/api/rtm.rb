module Slack
  module API
    class RTM < Base
      def start
        response = request :get, 'rtm.start'#, user: id
        Slack::Session.parse response
      end
    end
  end
end
