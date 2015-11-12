module Slack
  module API
    class Chat < Base
      def create(text, channel, options={})
        response = request :post, 'chat.postMessage', { text: text, channel: channel }.merge(options)
        Slack::Chat.parse response, 'message'
      end

      def delete(timestamp, channel)
        with_nil_response { request :post, 'chat.delete', ts: timestamp, channel: channel }
      end
    end
  end
end