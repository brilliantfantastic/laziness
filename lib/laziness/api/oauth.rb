module Slack
  module API
    class OAuth < Base
      def access(client_id, client_secret, code, redirect_uri=nil)
        response = request :get, 'oauth.access', client_id: client_id,
          client_secret: client_secret, code: code, redirect_uri: redirect_uri
        Slack::Auth.parse response
      end
    end
  end
end
