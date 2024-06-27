# frozen_string_literal: true

module DoorLoop
  class CommunicationLogs
    def initialize(client)
      @client = client
    end

    def list(options = {})
      @client.get('communications', options)
    end

    def create(params)
      @client.post('communications', params)
    end

    def retrieve(id)
      @client.get("communications/#{id}")
    end

    def update(id, params)
      @client.put("communications/#{id}", params)
    end

    def delete(id)
      @client.delete("communications/#{id}")
    end
  end
end
