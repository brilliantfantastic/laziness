module Slack
  module API
    class Auth < Base
      def test
        response = request :get, access_token, 'auth.test'
        Slack::Auth.parse response
      end
    end
  end
end
