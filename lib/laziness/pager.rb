require "ostruct"

module Slack
  class Pager
    attr_reader :cursor, :limit, :page

    def initialize(page)
      @page = page.dup
      @limit = @page[:limit] unless empty?
    end

    def empty?
      page.nil? || page.empty?
    end

    def to_h
      { cursor: cursor, limit: limit }
    end
  end
end
