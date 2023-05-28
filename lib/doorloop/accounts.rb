module DoorLoop
  class Accounts
    def initialize(client)
      @client = client
    end

    def list
      @client.get('accounts')
    end
  end
end
