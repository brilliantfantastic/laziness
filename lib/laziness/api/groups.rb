module Slack
  module API
    class Groups < Base
      def all(exclude_archived=false)
        response = request :get, access_token, 'groups.list', exclude_archived: exclude_archived ? 1 : 0
        Slack::Group.parse response, 'groups'
      end

      def archive(id)
        with_nil_response { request :post, access_token, 'groups.archive', channel: id }
      end

      def close(id)
        with_nil_response { request :post, access_token, 'groups.close', channel: id }
      end

      def copy(id)
        response = request :post, access_token, 'groups.createChild', channel: id
        Slack::Group.parse response, 'group'
      end

      def create(name)
        response = request :post, access_token, 'groups.create', name: name
        Slack::Group.parse response, 'group'
      end

      def find(id)
        response = request :get, access_token, 'groups.info', channel: id
        Slack::Group.parse response, 'group'
      end

      def invite(id, user_id)
        response = request :post, access_token, 'groups.invite', channel: id, user: user_id
        Slack::Group.parse response, 'group'
      end

      def kick(id, user_id)
        with_nil_response { request :post, access_token, 'groups.kick', channel: id, user: user_id }
      end

      def leave(id)
        with_nil_response { request :post, access_token, 'groups.leave', channel: id }
      end

      def unarchive(id)
        with_nil_response { request :post, access_token, 'groups.unarchive', channel: id }
      end
    end
  end
end
