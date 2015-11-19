module Slack
  module API
    class IM < Base
      def close(channel)
        with_nil_response { request :post, 'im.close', channel: channel }
      end

      def open(user_id)
        response = request :post, 'im.open', { user: user_id }
        Slack::Channel.parse response, 'channel'
      end
    end
  end
end
