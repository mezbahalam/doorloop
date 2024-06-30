# frozen_string_literal: true

module DoorLoop
  class LeaseCharges
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('lease-charges', options)
    end

    def create(params)
      @client.post('lease-charges', params)
    end

    def find(id)
      @client.get("lease-charges/#{id}")
    end

    def update(id, params)
      @client.put("lease-charges/#{id}", params)
    end

    def delete(id)
      @client.delete("lease-charges/#{id}")
    end
  end
end
