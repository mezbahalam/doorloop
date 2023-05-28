module DoorLoop
  class Properties
    def initialize(client)
      @client = client
    end

    def list
      @client.get('properties')
    end

    def get(id)
      @client.get("properties/#{id}")
    end
  end
end
