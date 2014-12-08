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

  class RestrictedActionError < APIError
    def initialize
      super "A team preference prevents authenticated user from archiving."
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

  class UserIsBotError < APIError
    def initialize
      super "This method cannot be called by a bot user."
    end
  end

  class UserIsRestrictedError < APIError
    def initialize
      super "This method cannot be called by a restricted user or single channel guest."
    end
  end

  class ChannelNotFoundError < APIError
    def initialize
      super "Channel value is invalid."
    end
  end

  class AlreadyArchivedError < APIError
    def initialize
      super "Channel has already been archived."
    end
  end

  class NotArchivedError < APIError
    def initialize
      super "Channel is not archived."
    end
  end

  class CantArchiveGeneralError < APIError
    def initialize
      super "You cannot archive the general channel."
    end
  end

  class LastRaChannelError < APIError
    def initialize
      super "You cannot archive the last channel for a restricted account."
    end
  end
end
