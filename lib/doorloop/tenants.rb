# frozen_string_literal: true

module DoorLoop
  class Tenants
    def initialize(client)
      @client = client
    end

    def find(id)
      @client.get("tenants/#{id}")
    end

    def list(options = {})
      @client.get('tenants', options)
    end

    def create(params)
      @client.post('tenants', params)
    end

    def update(id, params)
      @client.put("tenants/#{id}", params)
    end

    def delete(id)
      @client.delete("tenants/#{id}")
    end

  end
end

