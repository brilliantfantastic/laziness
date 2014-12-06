require 'laziness/api'
require 'laziness/client'
require 'laziness/user'

module Slack
  class << self
    def client(attributes={})
      Slack::Client.new(attributes[:access_token])
    end
  end
end
