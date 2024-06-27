# frozen_string_literal: true

module DoorLoop
  class LeaseReturnedPayments
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('lease-reversed-payments', options)
    end

    def create(params)
      @client.post('lease-reversed-payments', params)
    end

    def retrieve(id)
      @client.get("lease-reversed-payments/#{id}")
    end

    def update(id, params)
      @client.put("lease-reversed-payments/#{id}", params)
    end

    def delete(id)
      @client.delete("lease-reversed-payments/#{id}")
    end
  end
end
