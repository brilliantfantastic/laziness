module Slack
  class Cursor
    attr_reader :page

    def initialize(page)
      @page = page
    end

    def paginate(&blk)
      responses = []
      if block_given?
        pager = Pager.new(page)
        loop do
          response = blk.call(pager)
          responses << response

          break unless has_cursor?(response)

          pager = pager.next(next_cursor(response))
        end
      end
      responses
    end

    private

    def next_cursor(response)
      response["response_metadata"]["next_cursor"] unless !has_cursor?(response)
    end

    def has_cursor?(response)
      response.respond_to?(:[]) &&
        !response["response_metadata"].nil? &&
          !response["response_metadata"]["next_cursor"].nil?
    end
  end
end
