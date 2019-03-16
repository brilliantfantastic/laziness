module Slack
  module API
    class Channels < Base
      def all(exclude_archived=false, page: nil)
        responses = with_paging(page) do |pager|
          request :get,
                  'channels.list',
                  exclude_archived: exclude_archived ? 1 : 0,
                  **pager.to_h
        end

        Slack::Channel.parse_all responses, 'channels'
      end

      def archive(id)
        with_nil_response { request :post, 'channels.archive', channel: id }
      end

      def create(name)
        response = request :post, 'channels.create', name: name
        Slack::Channel.parse response, 'channel'
      end

      def find(id)
        response = request :get, 'channels.info', channel: id
        Slack::Channel.parse response, 'channel'
      end

      def unarchive(id)
        with_nil_response { request :post, 'channels.unarchive', channel: id }
      end
    end
  end
end
