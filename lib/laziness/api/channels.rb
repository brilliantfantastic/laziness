module Slack
  module API
    class Channels < Base
      def all(exclude_archived=false)
        response = request :get, access_token, 'channels.list', exclude_archived: exclude_archived ? 1 : 0
        Slack::Channel.parse response, 'channels'
      end

      def find(id)
        response = request :get, access_token, 'channels.info', channel: id
        Slack::Channel.parse response, 'channel'
      end

      def archive(id)
        request :post, access_token, 'channels.archive', channel: id
        nil
      end

      def unarchive(id)
        request :post, access_token, 'channels.unarchive', channel: id
        nil
      end
    end
  end
end
