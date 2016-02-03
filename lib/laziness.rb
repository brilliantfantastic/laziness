require "laziness/version"
require "laziness/api"
require "laziness/base"
require "laziness/auth"
require "laziness/channel"
require "laziness/chat"
require "laziness/web_client"
require "laziness/errors"
require "laziness/group"
require "laziness/message"
require "laziness/oauth"
require "laziness/observer"
require "laziness/real_time_client"
require "laziness/registry"
require "laziness/session"
require "laziness/user"

module Slack
  class << self
    def web_client(attributes={})
      Slack::WebClient.new(attributes[:access_token])
    end
  end
end
