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

      def create(name, is_private=false, user_ids=[])
        response = request :post,
          'conversations.create',
          name: name,
          is_private: is_private,
          user_ids: user_ids

        Slack::Conversation.parse response, 'channel'
      end

      def find(id)
        response = request :get, 'conversations.info', channel: id
        Slack::Conversation.parse response, 'channel'
      end

      def invite(id, users)
        response = request :post,
          'conversations.invite',
          channel: id,
          users: users.join(",")

        Slack::Conversation.parse response, 'channel'
      end

      def join(id)
        response = request :post,
          'conversations.join',
          channel: id

        Slack::Conversation.parse response, 'channel'
      end

      def kick(id, user)
        with_nil_response { request :post, 'conversations.kick', channel: id, user: user }
      end

      def leave(id)
        with_nil_response { request :post, 'conversations.leave', channel: id }
      end

      def members(id)
        response = request :get,
          'conversations.members',
          channel: id

        JSON.parse(response.body)["members"]
      end

      def open(users=[], id=nil, return_im: false)
        response = request :post,
          'conversations.open',
          channel: id,
          users: (users || []).join(","),
          return_im: return_im

        Slack::Conversation.parse response, 'channel'
      end

      def rename(id, name)
        response = request :post,
          'conversations.rename',
          channel: id,
          name: name

        Slack::Conversation.parse response, 'channel'
      end

      def set_purpose(id, purpose)
        with_nil_response do
          request :post,
          'conversations.setPurpose',
          channel: id,
          purpose: purpose
        end
      end

      def set_topic(id, topic)
        with_nil_response do
          request :post,
          'conversations.setTopic',
          channel: id,
          topic: topic
        end
      end

      def unarchive(id)
        with_nil_response { request :post, 'conversations.unarchive', channel: id }
      end
    end
  end
end
