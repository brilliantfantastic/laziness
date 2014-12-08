module Slack
  class APIError < StandardError
    def initialize(message)
      super message
    end
  end

  class NotAuthedError < APIError
    def initialize
      super "No authentication token provided."
    end
  end

  class InvalidAuthError < APIError
    def initialize
      super "Invalid authentication token."
    end
  end

  class AccountInactiveError < APIError
    def initialize
      super "Authentication token is for a deleted user or team."
    end
  end

  class UserNotFoundError < APIError
    def initialize
      super "User value is invalid."
    end
  end

  class UserNotVisibleError < APIError
    def initialize
      super "Not authorized to view the requested user."
    end
  end
end
