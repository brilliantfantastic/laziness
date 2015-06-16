module Slack
  module API
    class Groups < Base
      def all(exclude_archived=false)
        response = request :get, access_token, 'groups.list', exclude_archived: exclude_archived ? 1 : 0
        Slack::Group.parse response, 'groups'
      end
    end
  end
end
