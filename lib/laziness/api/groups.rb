module Slack
  module API
    class Groups < Base
      def all(exclude_archived=false)
        response = request :get, access_token, 'groups.list', exclude_archived: exclude_archived ? 1 : 0
        Slack::Group.parse response, 'groups'
      end

      def find(id)
        response = request :get, access_token, 'groups.info', channel: id
        Slack::Group.parse response, 'group'
      end

      def create(name)
        response = request :post, access_token, 'groups.create', name: name
        Slack::Group.parse response, 'group'
      end

      def archive(id)
        request :post, access_token, 'groups.archive', channel: id
        nil
      end

      def unarchive(id)
        request :post, access_token, 'groups.unarchive', channel: id
        nil
      end
    end
  end
end
