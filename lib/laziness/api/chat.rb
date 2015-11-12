module Slack
  module API
    class Chat < Base
      def create(text, channel, options={})
        response = request :post, 'chat.postMessage', { text: text, channel: channel }.merge(options)
        Slack::Chat.parse response, 'message'
      end
    end
  end
end
