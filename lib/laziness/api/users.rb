module Slack
  module API
    class Users < Base
      def all
        response = request :get, 'users.list'
        Slack::User.parse response, 'members'
      end

      def find(id)
        response = request :get, 'users.info', user: id
        Slack::User.parse response, 'user'
      end

      def set_active
        with_nil_response { request :post, 'users.setActive' }
      end
    end
  end
end
