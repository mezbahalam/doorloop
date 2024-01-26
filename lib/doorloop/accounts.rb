module DoorLoop
  class Accounts
    def initialize(client)
      @client = client
    end


    def list(options = {})
      @client.get('accounts', options)
    end
  end
end
