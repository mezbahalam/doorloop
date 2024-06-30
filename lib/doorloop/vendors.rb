# frozen_string_literal: true

module DoorLoop
  class Vendors
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('vendors', options)
    end

    def create(params)
      @client.post('vendors', params)
    end

    def find(id)
      @client.get("vendors/#{id}")
    end

    def update(id, params)
      @client.put("vendors/#{id}", params)
    end

    def delete(id)
      @client.delete("vendors/#{id}")
    end
  end
end
