module Slack
  module API
    class IM < Base
      def close(channel)
        with_nil_response { request :post, 'im.close', channel: channel }
      end
    end
  end
end
