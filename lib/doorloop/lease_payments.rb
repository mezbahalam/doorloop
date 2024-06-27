# frozen_string_literal: true

module DoorLoop
  class LeasePayments
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('lease-payments', options)
    end

    def create(params)
      @client.post('lease-payments', params)
    end

    def retrieve(id)
      @client.get("lease-payments/#{id}")
    end

    def update(id, params)
      @client.put("lease-payments/#{id}", params)
    end

    def delete(id)
      @client.delete("lease-payments/#{id}")
    end
  end
end
