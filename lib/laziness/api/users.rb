module Slack
  module API
    class Users
      attr_reader :access_token

      def initialize(access_token)
        @access_token = access_token
      end

      def all
        response = request :get, access_token, 'users.list'
        Slack::User.parse response, 'members'
      end

      def find(id)
        response = request :get, access_token, 'users.info', user: id
        Slack::User.parse response, 'user'
      end

      def set_active
        request :post, access_token, 'users.setActive'
        nil
      end

      private

      def base_path
        "https://slack.com/api/"
      end

      def request(method, access_token, path, arguments={})
        full_path = "#{base_path}#{path}?token=#{access_token}"
        arguments.each_pair { |key, value| full_path = "#{full_path}&#{key}=#{value}" }
        options = {
          headers: {
            "Accept"       => "application/json",
            "Content-Type" => "application/json; charset=utf-8"
          }
        }
        response = HTTParty.send method, full_path, options
        handle_exceptions response
        response
      end

      def handle_exceptions(response)
        parsed = JSON.parse(response)
        if !parsed['ok']
          klass = "#{parsed['error'].gsub(/(^|_)(.)/) { $2.upcase }}Error"
          if Slack.const_defined? klass
            raise Slack.const_get(klass)
          else
            raise Slack::APIError.new parsed['error']
          end
        end
      end
    end
  end
end