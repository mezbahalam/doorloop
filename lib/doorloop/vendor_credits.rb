# frozen_string_literal: true

module DoorLoop
  class VendorCredits
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('vendor-credits', options)
    end

    def create(params)
      @client.post('vendor-credits', params)
    end

    def retrieve(id)
      @client.get("vendor-credits/#{id}")
    end

    def update(id, params)
      @client.put("vendor-credits/#{id}", params)
    end

    def delete(id)
      @client.delete("vendor-credits/#{id}")
    end
  end
end
