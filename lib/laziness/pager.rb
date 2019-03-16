require "ostruct"

module Slack
  class Pager
    attr_reader :cursor, :limit, :page

    def initialize(page)
      @page = page
      @limit = @page[:limit] unless empty?
    end

    def empty?
      page.nil? || page.empty?
    end

    def to_h
      { cursor: cursor, limit: limit }
    end

    def next(cursor)
      self.class.new(page).tap do |pager|
        pager.cursor = cursor
      end
    end

    protected

    def cursor=(cursor)
      @cursor = cursor
    end
  end
end
