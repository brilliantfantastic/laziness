module Slack
  module API
    class Channels < Base
      def all(exclude_archived=false)
        response = request :get, access_token, 'channels.list', exclude_archived: exclude_archived ? 1 : 0
        Slack::Channel.parse response, 'channels'
      end

      def archive(id)
        with_nil_response { request :post, access_token, 'channels.archive', channel: id }
      end

      def create(name)
        response = request :post, access_token, 'channels.create', name: name
        Slack::Channel.parse response, 'channel'
      end

      def find(id)
        response = request :get, access_token, 'channels.info', channel: id
        Slack::Channel.parse response, 'channel'
      end

      def unarchive(id)
        with_nil_response { request :post, access_token, 'channels.unarchive', channel: id }
      end
    end
  end
end
