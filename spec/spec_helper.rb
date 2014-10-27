require 'simplecov'

SimpleCov.start do
  add_group('BigcommerceOAuthAPI', 'lib/bigcommerce_oauth_api')
  add_group('Specs', 'spec')
end

require 'bigcommerce_oauth_api'

require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

def stub_get(client, path)
  stub_request(:get, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def a_get(client, path)
  a_request(:get, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end