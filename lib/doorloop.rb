# frozen_string_literal: true

require_relative 'doorloop/version'
require_relative 'doorloop/client'

module DoorLoop
  class Error < StandardError; end
  class UnauthorizedError < Error; end
  class ForbiddenError < Error; end
  class NotFoundError < Error; end
  class TooManyRequestsError < Error; end
  class InvalidResponseError < Error; end
end
