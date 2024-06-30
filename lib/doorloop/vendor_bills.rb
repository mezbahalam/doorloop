# frozen_string_literal: true

module DoorLoop
  class VendorBills
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('vendor-bills', options)
    end

    def create(params)
      @client.post('vendor-bills', params)
    end

    def find(id)
      @client.get("vendor-bills/#{id}")
    end

    def update(id, params)
      @client.put("vendor-bills/#{id}", params)
    end

    def delete(id)
      @client.delete("vendor-bills/#{id}")
    end
  end
end
