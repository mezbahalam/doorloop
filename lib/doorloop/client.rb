# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'logger'
require_relative 'accounts'
require_relative 'properties'

module DoorLoop
  class Client
    attr_accessor :api_base_url, :retry_on_rate_limit

    def initialize(api_token, api_base_url: 'https://app.doorloop.com/api', retry_on_rate_limit: false)
      @api_token = api_token
      @api_base_url = api_base_url
      @retry_on_rate_limit = retry_on_rate_limit
      @logger = Logger.new($stdout)
      @error_handler = ErrorHandler.new(@logger, self)
    end

    def accounts
      Accounts.new(self)
    end

    def properties
      Properties.new(self)
    end

    def get(path, options = {})
      url = build_url(path, options)
      response = make_request(url)
      parse_response(response)
    end

    private

    def headers
      {
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{@api_token}"
      }
    end

    def build_url(path, options)
      defaults = { page_number: 1, page_size: 50, sort_by: nil, sort_descending: false }
      options = defaults.merge(options)

      uri = URI.join(@api_base_url, path)
      uri.query = URI.encode_www_form(options) if options.any?
      uri.to_s
    rescue StandardError => e
      @logger.error("Error building URL: #{e.message}")
      raise DoorLoop::Error, "Error building URL: #{e.message}"
    end

    def parse_response(response)
      JSON.parse(response.body)
    end

    def make_request(url)
      RestClient.get(url, headers)
    rescue RestClient::ExceptionWithResponse => e
      @error_handler.handle(e)
    end
  end
end
