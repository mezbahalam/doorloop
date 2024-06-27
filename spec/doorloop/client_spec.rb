# frozen_string_literal: true

require 'doorloop/client'

RSpec.describe DoorLoop::Client do
  let(:api_token) { 'your_token' }
  let(:api_base_url) { 'https://app.doorloop.com/api' }
  let(:retry_on_rate_limit) { false }
  let(:client) { DoorLoop::Client.new(api_token, api_base_url: api_base_url, retry_on_rate_limit: retry_on_rate_limit) }

  describe '#initialize' do
    it 'initializes with correct api_token' do
      expect(client.api_token).to eq(api_token)
    end

    it 'initializes with correct api_base_url' do
      expect(client.api_base_url).to eq(api_base_url)
    end

    it 'initializes with correct retry_on_rate_limit' do
      expect(client.retry_on_rate_limit).to eq(retry_on_rate_limit)
    end
  end

  describe '#get' do
    before do
      stub_request(:get, 'https://app.doorloop.com/test_path?page_number=1&page_size=50')
        .with(
          headers: {
            'Accept' => 'application/json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer your_token',
            'Host' => 'app.doorloop.com',
            'User-Agent' => 'rest-client/2.1.0 (darwin21 arm64) ruby/3.1.2p20'
          }
        )
        .to_return(status: 200, body: '{"data": "test"}', headers: {})
    end

    it 'makes a GET request and returns parsed response' do
      response = client.get('/test_path')
      expect(response).to eq('data' => 'test')
    end
  end

  describe '#build_url' do
    it 'raises an error when URL building fails' do
      allow(URI).to receive(:join).and_raise(StandardError.new('Test error'))
      expect { client.get('/test_path') }.to raise_error(DoorLoop::Error, 'Error building URL: Test error')
    end
  end

  describe '#accounts' do
    it 'returns an instance of Accounts' do
      expect(client.accounts).to be_an_instance_of(DoorLoop::Accounts)
    end
  end

  describe '#properties' do
    it 'returns an instance of Properties' do
      expect(client.properties).to be_an_instance_of(DoorLoop::Properties)
    end
  end
end
