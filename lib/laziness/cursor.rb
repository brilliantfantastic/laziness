module Slack
  class Cursor
    attr_reader :page

    def initialize(page)
      @page = page
    end

    def paginate(&blk)
      blk.call(Pager.new(page)) if block_given?
    end
  end
end
