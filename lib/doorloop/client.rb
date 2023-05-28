require 'rest-client'
require 'json'
require_relative 'accounts'
require_relative 'properties'

module DoorLoop
  class Client
    API_BASE_URL = 'https://app.doorloop.com/api'

    def initialize(api_token)
      @api_token = api_token
    end

    def accounts
      Accounts.new(self)
    end

    def properties
      Properties.new(self)
    end

    def get(path)
      response = RestClient.get("#{API_BASE_URL}/#{path}", headers)
      JSON.parse(response.body)
    end

    private

    def headers
      {
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{@api_token}"
      }
    end
  end
end
