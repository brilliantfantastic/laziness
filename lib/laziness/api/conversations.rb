module Slack
  module API
    class Conversations < Base
      def all(exclude_archived=false, types='public_channel')
        response = request :get,
          'conversations.list',
          exclude_archived: exclude_archived ? 1 : 0,
          types: types

        Slack::Conversation.parse response, 'channels'
      end

      def archive(id)
        with_nil_response { request :post, 'conversations.archive', channel: id }
      end

      def close(id)
        with_nil_response { request :post, 'conversations.close', channel: id }
      end

      def find(id)
        response = request :get, 'conversations.info', channel: id
        Slack::Conversation.parse response, 'channel'
      end
    end
  end
end
