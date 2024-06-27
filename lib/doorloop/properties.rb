# frozen_string_literal: true

module DoorLoop
  class Properties
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('properties', options)
    end

    def retrieve(id)
      @client.get("properties/#{id}")
    end
  end
end
