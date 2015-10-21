require 'laziness/version'
require 'laziness/api'
require 'laziness/base'
require 'laziness/auth'
require 'laziness/channel'
require 'laziness/client'
require 'laziness/errors'
require 'laziness/group'
require 'laziness/session'
require 'laziness/oauth'
require 'laziness/user'
require 'laziness/websocket'

module Slack
  class << self
    def client(attributes={})
      Slack::Client.new(attributes[:access_token])
    end
  end
end
