module Slack
  module API
    class Groups < Base
      def all(exclude_archived=false)
        response = request :get, 'groups.list', exclude_archived: exclude_archived ? 1 : 0
        Slack::Group.parse response, 'groups'
      end

      def archive(id)
        with_nil_response { request :post, 'groups.archive', channel: id }
      end

      def close(id)
        with_nil_response { request :post, 'groups.close', channel: id }
      end

      def copy(id)
        response = request :post, 'groups.createChild', channel: id
        Slack::Group.parse response, 'group'
      end

      def create(name)
        response = request :post, 'groups.create', name: name
        Slack::Group.parse response, 'group'
      end

      def find(id)
        response = request :get, 'groups.info', channel: id
        Slack::Group.parse response, 'group'
      end

      def invite(id, user_id)
        response = request :post, 'groups.invite', channel: id, user: user_id
        Slack::Group.parse response, 'group'
      end

      def kick(id, user_id)
        with_nil_response { request :post, 'groups.kick', channel: id, user: user_id }
      end

      def leave(id)
        with_nil_response { request :post, 'groups.leave', channel: id }
      end

      def open(id)
        with_nil_response { request :post, 'groups.open', channel: id }
      end

      def unarchive(id)
        with_nil_response { request :post, 'groups.unarchive', channel: id }
      end

      def update_purpose(id, purpose)
        with_nil_response { request :post, 'groups.setPurpose', channel: id, purpose: purpose }
      end

      def update_topic(id, topic)
        with_nil_response { request :post, 'groups.setTopic', channel: id, topic: topic }
      end
    end
  end
end
