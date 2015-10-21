module Slack
  module API
    class RTM < Base
      def start(simple_latest=false, no_unreads=false)
        parameters = {}
        parameters[:simple_latest] = simple_latest if simple_latest
        parameters[:no_unreads] = no_unreads if no_unreads
        response = request :get, 'rtm.start', parameters
        Slack::Session.parse response
      end
    end
  end
end
