# frozen_string_literal: true

module DoorLoop
  class Owners
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('owners', options)
    end

    def create(params)
      @client.post('owners', params)
    end

    def retrieve(task_id)
      @client.get("owners/#{id}")
    end

    def update(id, params)
      @client.put("owners/#{id}", params)
    end

    def delete(id)
      @client.delete("owners/#{id}")
    end
  end
end
