module Slack
  module API
    class Channels < Base
      def all(exclude_archived=false)
        response = request :get, access_token, 'channels.list', exclude_archived: exclude_archived ? 1 : 0
        Slack::Channel.parse response, 'channels'
      end
    end
  end
end
