module Slack
  module API
    class IM < Base
      def all
        response = request :get, 'im.list'
        Slack::Channel.parse response, 'ims'
      end

      def close(channel)
        with_nil_response { request :post, 'im.close', channel: channel }
      end

      def mark(channel, timestamp)
        with_nil_response { request :post, 'im.mark', channel: channel, ts: timestamp }
      end

      def open(user_id)
        response = request :post, 'im.open', { user: user_id }
        Slack::Channel.parse response, 'channel'
      end
    end
  end
end