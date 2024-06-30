# frozen_string_literal: true

module DoorLoop
  class Notes
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('notes', options)
    end

    def create(params)
      @client.post('notes', params)
    end

    def find(task_id)
      @client.get("notes/#{id}")
    end

    def update(id, params)
      @client.put("notes/#{id}", params)
    end

    def delete(id)
      @client.delete("notes/#{id}")
    end
  end
end
