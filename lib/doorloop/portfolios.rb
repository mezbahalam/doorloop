# frozen_string_literal: true

module DoorLoop
  class Portfolios
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('property-groups', options)
    end

    def find(id)
      @client.get("property-groups/#{id}")
    end
  end
end
