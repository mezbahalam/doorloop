# frozen_string_literal: true

require 'spec_helper'
require 'doorloop'

RSpec.describe DoorLoop do
  describe 'Error classes' do
    it 'defines the correct error classes' do
      expect(DoorLoop::Error).to be < StandardError
      expect(DoorLoop::UnauthorizedError).to be < DoorLoop::Error
      expect(DoorLoop::ForbiddenError).to be < DoorLoop::Error
      expect(DoorLoop::NotFoundError).to be < DoorLoop::Error
      expect(DoorLoop::TooManyRequestsError).to be < DoorLoop::Error
      expect(DoorLoop::InvalidResponseError).to be < DoorLoop::Error
    end
  end
end
