# frozen_string_literal: true

module DoorLoop
  class ErrorHandler
    def initialize(logger, client)
      @logger = logger
      @client = client
    end

    def handle(exception)
      case exception.http_code
      when 401
        @logger.error('Unauthorized access')
        raise DoorLoop::UnauthorizedError, 'Unauthorized access'
      when 403
        @logger.error('Forbidden access')
        raise DoorLoop::ForbiddenError, 'Forbidden access'
      when 404
        @logger.error('Resource not found')
        raise DoorLoop::NotFoundError, 'Resource not found'
      when 429
        handle_rate_limit(exception)
      else
        @logger.error("Unexpected error: #{exception}")
        raise DoorLoop::Error, "Unexpected error: #{exception}"
      end
    end

    def handle_rate_limit(exception)
      retry_after = exception.response.headers[:retry_after].to_i
      if @client.retry_on_rate_limit
        begin
          @logger.warn("Rate limit exceeded, retrying in #{retry_after} seconds...")
          sleep(retry_after)
        rescue DoorLoop::TooManyRequestsError
          retry
        end
      else
        @logger.warn("Rate limit exceeded, retry after #{retry_after} seconds.")
        raise DoorLoop::TooManyRequestsError, 'Rate limit exceeded'
      end
    end
  end
end
