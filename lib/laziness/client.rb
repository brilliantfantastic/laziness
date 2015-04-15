module Slack
  class Client
    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def auth
      @auth ||= Slack::API::Auth.new(access_token)
    end

    def users
      @users ||= Slack::API::Users.new(access_token)
    end

    def channels
      @channels ||= Slack::API::Channels.new(access_token)
    end
  end
end
