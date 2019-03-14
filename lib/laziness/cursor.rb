module Slack
  class Cursor
    attr_reader :page

    def initialize(page, &blk)
      @page = page
      paginate(&blk)
    end

    private

    def paginate(&blk)
      blk.call(Pager.new) if block_given?
    end
  end
end
