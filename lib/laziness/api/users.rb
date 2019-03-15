module Slack
  module API
    class Users < Base
      def all(page: nil)
        responses = with_paging(page) do |pager|
          request :get, 'users.list', **pager.to_h
        end

        Slack::User.parse_all responses, 'members'
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
