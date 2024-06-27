# frozen_string_literal: true

module DoorLoop
  class Accounts
    def initialize(client)
      @client = client
    end


    def list(options = {})
      @client.get('accounts', options)
    end

    def create(params)
      @client.post('accounts', params)
    end

    def retrieve(id)
      @client.get("accounts/#{id}")
    end

    def update(id, params)
      @client.put("accounts/#{id}", params)
    end

    def delete(id)
      @client.delete("accounts/#{id}")
    end
  end
end
