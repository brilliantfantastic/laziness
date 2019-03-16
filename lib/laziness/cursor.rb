module Slack
  class Cursor
    attr_reader :page

    def initialize(page)
      @page = page
      @max_retries = (page && page[:max_retries]) || 0
      @sleep_interval = (page && page[:sleep_interval])
    end

    def paginate(&blk)
      responses = []

      if block_given?
        pager = Pager.new(page)
        retries = 0

        loop do
          begin
            response = blk.call(pager)
          rescue Slack::TooManyRequestsError => e
            raise e if retries >= max_retries

            retries += 1

            sleep(e.retry_after_in_seconds)
            next
          end

          responses << response

          break unless has_cursor?(response)

          retries = 0

          pager = pager.next(next_cursor(response))

          sleep(sleep_interval) if sleep_interval
        end
      end

      responses
    end

    private

    attr_reader :max_retries, :sleep_interval

    def next_cursor(response)
      response["response_metadata"]["next_cursor"] unless !has_cursor?(response)
    end

    def has_cursor?(response)
      response.respond_to?(:[]) &&
        !response["response_metadata"].nil? &&
          !response["response_metadata"]["next_cursor"].nil? &&
          !response["response_metadata"]["next_cursor"].empty?
    end
  end
end
