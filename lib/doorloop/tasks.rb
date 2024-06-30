# frozen_string_literal: true

module DoorLoop
  class Tasks
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('tasks', options)
    end

    def create(params)
      @client.post('tasks', params)
    end

    def find(id)
      @client.get("tasks/#{id}")
    end

    def update(id, params)
      @client.put("tasks/#{id}", params)
    end

    def delete(id)
      @client.delete("tasks/#{id}")
    end

    def post_update(params)
      @client.post('tasks/update', params)
    end
  end
end
