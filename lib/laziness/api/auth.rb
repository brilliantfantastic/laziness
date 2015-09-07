module Slack
  module API
    class Auth < Base
      def test
        response = request :get, 'auth.test'
        Slack::Auth.parse response
      end
    end
  end
end
