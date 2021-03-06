module Slack
  class Client
    attr_reader :access_token

    def initialize(access_token=nil)
      @access_token = access_token
    end

    def auth
      @auth ||= Slack::API::Auth.new(access_token)
    end

    def channels
      @channels ||= Slack::API::Channels.new(access_token)
    end

    def chat
      @chat ||= Slack::API::Chat.new(access_token)
    end

    def conversations
      @conversations ||= Slack::API::Conversations.new(access_token)
    end

    def im
      @im ||= Slack::API::IM.new(access_token)
    end

    def groups
      @groups ||= Slack::API::Groups.new(access_token)
    end

    def oauth
      @oauth ||= Slack::API::OAuth.new
    end

    def rtm
      @rtm ||= Slack::API::RTM.new(access_token)
    end

    def users
      @users ||= Slack::API::Users.new(access_token)
    end
  end
end
