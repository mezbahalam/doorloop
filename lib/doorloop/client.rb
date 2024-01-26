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

    def get(path, options = {})
      defaults = { page_number: 1, page_size: 50, sort_by: nil, sort_descending: false }
      options = defaults.merge(options)

      url = "#{API_BASE_URL}/#{path}"
      if options.any?
        query_string = options.map { |k, v| "#{k}=#{v}" }.join('&')
        separator = url.include?('?') ? '&' : '?'
        url += "#{separator}#{query_string}"
      end
      response = make_request(url)
      begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        puts "Error: the API response is not a valid JSON"
      end
    end

    private

    def headers
      {
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{@api_token}"
      }
    end

    def make_request(url)
      response = RestClient.get(url, headers)
    rescue RestClient::TooManyRequests => e
      retry_after = e.response.headers[:retry_after].to_i
      puts "Rate limit exceeded, retrying in #{retry_after} seconds..."
      sleep(retry_after)
      retry
    end
  end
end
