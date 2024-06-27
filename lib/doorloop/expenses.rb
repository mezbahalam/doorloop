# frozen_string_literal: true

module DoorLoop
  class Expenses
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('expenses', options)
    end

    def create(params)
      @client.post('expenses', params)
    end

    def retrieve(id)
      @client.get("expenses/#{id}")
    end

    def update(id, params)
      @client.put("expenses/#{id}", params)
    end

    def delete(id)
      @client.delete("expenses/#{id}")
    end
  end
end
