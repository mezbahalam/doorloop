# frozen_string_literal: true

require_relative 'doorloop/version'
require_relative 'doorloop/client'

module DoorLoop
  class << self
    def client(api_token, api_base_url: 'https://app.doorloop.com/api', retry_on_rate_limit: false)
      Client.new(api_token, api_base_url, retry_on_rate_limit)
    end
  end

  class Error < StandardError; end
  class UnauthorizedError < Error; end
  class ForbiddenError < Error; end
  class NotFoundError < Error; end
  class TooManyRequestsError < Error; end
  class InvalidResponseError < Error; end
end
