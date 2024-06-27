# frozen_string_literal: true

module DoorLoop
  class LeaseCredits
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('lease-credits', options)
    end

    def create(params)
      @client.post('lease-credits', params)
    end

    def retrieve(id)
      @client.get("lease-credits/#{id}")
    end

    def update(id, params)
      @client.put("lease-credits/#{id}", params)
    end

    def delete(id)
      @client.delete("lease-credits/#{id}")
    end
  end
end
