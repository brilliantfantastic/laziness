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
    end
  end
end
