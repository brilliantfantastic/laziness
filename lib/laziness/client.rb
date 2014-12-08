module Slack
  class Client
    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def users
      @users ||= Slack::API::Users.new(access_token)
    end
  end
end
