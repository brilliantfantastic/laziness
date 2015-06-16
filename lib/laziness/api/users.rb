module Slack
  module API
    class Users < Base
      def all
        response = request :get, access_token, 'users.list'
        Slack::User.parse response, 'members'
      end

      def find(id)
        response = request :get, access_token, 'users.info', user: id
        Slack::User.parse response, 'user'
      end

      def set_active
        with_nil_response { request :post, access_token, 'users.setActive' }
      end
    end
  end
end
