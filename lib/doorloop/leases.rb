# frozen_string_literal: true

module DoorLoop
  class Leases
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('leases', options)
    end

    def retrieve(id)
      @client.get("leases/#{id}")
    end

    def move_in_tenant(params)
      @client.post('leases/move-in', params)
    end

    def move_out_tenant(params)
      @client.post('leases/move-out', params)
    end

    def tenants
      @client.get('leases/tenants')
    end

  end
end
