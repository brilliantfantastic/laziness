module Slack
  module API
    class Users
      attr_reader :access_token

      def initialize(access_token)
        @access_token = access_token
      end

      def all
        response = request :get, access_token, 'users.list'
        Slack::User.parse response
      end

      private

      def base_path
        "https://slack.com/api/"
      end

      def request(method, access_token, path)
        full_path = "#{base_path}#{path}?token=#{access_token}"
        options = {
          headers: {
            "Accept"       => "application/json",
            "Content-Type" => "application/json; charset=utf-8"
          }
        }
        HTTParty.send method, full_path, options
      end
    end
  end
end
