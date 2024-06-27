# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'logger'
require_relative 'error_handler'
require_relative 'accounts'
require_relative 'properties'
require_relative 'units'
require_relative 'users'
require_relative 'leases'
require_relative 'tenants'
require_relative 'lease_payments'
require_relative 'lease_charges'
require_relative 'lease_returned_payments'
require_relative 'lease_credits'
require_relative 'portfolios'
require_relative 'tasks'
require_relative 'owners'
require_relative 'vendors'
require_relative 'expenses'
require_relative 'vendor_bills'
require_relative 'vendor_credits'
require_relative 'reports'
require_relative 'communication_logs'
require_relative 'notes'
require_relative 'files'


module DoorLoop
  class Client
    attr_accessor :api_token, :api_base_url, :retry_on_rate_limit, :logger

    def initialize(api_token, api_base_url: 'https://app.doorloop.com/api/', retry_on_rate_limit: false)
      @api_token = api_token
      @api_base_url = api_base_url
      @retry_on_rate_limit = retry_on_rate_limit
      @logger = Logger.new($stdout)
      @error_handler = DoorLoop::ErrorHandler.new(@logger, self)
    end

    def accounts
      Accounts.new(self)
    end

    def properties
      Properties.new(self)
    end

    def units
      Units.new(self)
    end

    def users
      Users.new(self)
    end

    def leases
      Leases.new(self)
    end

    def tenants
      Tenants.new(self)
    end

    def lease_payments
      LeasePayments.new(self)
    end

    def lease_returned_payments
      LeaseReturnedPayments.new(self)
    end

    def lease_charges
      LeaseCharges.new(self)
    end

    def lease_credits
      LeaseCredits.new(self)
    end

    def portfolios
      Portfolios.new(self)
    end

    def tasks
      Tasks.new(self)
    end

    def owners
      Owners.new(self)
    end

    def vendors
      Vendors.new(self)
    end

    def expenses
      Expenses.new(self)
    end

    def vender_bills
      VendorBills.new(self)
    end

    def vendor_credits
      VendorCredits.new(self)
    end

    def reports
      Reports.new(self)
    end

    def notes
      Notes.new(self)
    end

    def files
      Files.new(self)
    end

    def communication_logs
      CommunicationLogs.new(self)
    end

    def get(path, options = {})
      url = build_url(path, options)
      response = make_request(url)
      parse_response(response)
    end

    def post(path, payload)
      url = build_url(path)
      response = make_post_request(url, payload)
      parse_response(response)
    end

    def put(path, payload)
      url = build_url(path)
      response = make_put_request(url, payload)
      parse_response(response)
    end

    def delete(path)
      url = build_url(path)
      response = make_delete_request(url)
      parse_response(response)
    end


    private

    def headers
      {
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{@api_token}",
        'Content-Type' => 'application/json'
      }
    end

    def build_url(path, options = {})
      defaults = { page_number: 1, page_size: 50, sort_by: nil, sort_descending: false }
      options = defaults.merge(options)

      options.delete(:sort_by) if options[:sort_by].nil?
      options.delete(:sort_descending) if options[:sort_descending] == false

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

    def make_post_request(url, payload)
      RestClient.post(url, payload.to_json, headers)
    rescue RestClient::ExceptionWithResponse => e
      @error_handler.handle(e)
    end

    def make_put_request(url, payload)
      RestClient.put(url, payload.to_json, headers)
    rescue RestClient::ExceptionWithResponse => e
      @logger.error("PUT request failed: #{e.response}")
      @error_handler.handle(e)
    end

    def make_delete_request(url)
      RestClient.delete(url, headers)
    rescue RestClient::ExceptionWithResponse => e
      @error_handler.handle(e)
    end
  end
end
