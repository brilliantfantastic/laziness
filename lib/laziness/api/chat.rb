module Slack
  module API
    class Chat < Base
      def create(text, channel, options={})
        response = request :post, 'chat.postMessage', { text: text, channel: channel }.merge(options)
        Slack::Chat.parse response, 'message'
      end

      def delete(channel, timestamp)
        with_nil_response { request :post, 'chat.delete', ts: timestamp, channel: channel }
      end

      def update(text, channel, timestamp, options={})
        response = request :post, 'chat.update',
          { text: text, channel: channel, ts: timestamp }.merge(options)
        Slack::Chat.parse response, 'message'
      end
    end
  end
end
