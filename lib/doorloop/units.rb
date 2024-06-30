# frozen_string_literal: true

module DoorLoop
  class Units
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('units', options)
    end

    def find(id)
      @client.get("units/#{id}")
    end
  end
end
