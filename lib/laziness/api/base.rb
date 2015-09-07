module Slack
  module API
    class Base
      attr_reader :access_token

      def initialize(access_token=nil)
        @access_token = access_token
      end

      protected

      def base_path
        "https://slack.com/api/"
      end

      def with_nil_response
        yield
        nil
      end

      def request(method, path, arguments={})
        full_path = "#{base_path}#{path}"
        full_path = "#{full_path}?token=#{access_token}" unless access_token.nil?
        arguments.each_pair do |key, value|
          seperator = full_path.include?("?") ? "&" : "?"
          full_path = "#{full_path}#{seperator}#{key}=#{ERB::Util.url_encode(value)}"
        end

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
        parsed = JSON.parse(response.body)
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
