# frozen_string_literal: true

module DoorLoop
  class Users
    def initialize(client)
      @client = client
    end

    def get_current_user
      @client.get('users/me')
    end

    def list(options = {})
      @client.get('users', options)
    end

    def retrieve(id)
      @client.get("users/#{id}")
    end

  end
end

