require 'simplecov'
require 'codeclimate-test-reporter'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]
  add_group('BigcommerceOAuthAPI', 'lib/bigcommerce_oauth_api')
  add_group('Faraday', 'lib/faraday')
  add_group('Specs', 'spec')
end

require 'bigcommerce_oauth_api'

require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

WebMock.disable_net_connect!(:allow => 'codeclimate.com')

def stub_get(client, path)
  stub_request(:get, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def stub_post(client, path)
  stub_request(:post, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def stub_put(client, path)
  stub_request(:put, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def stub_delete(client, path)
  stub_request(:delete, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def a_get(client, path)
  a_request(:get, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def a_post(client, path)
  a_request(:post, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def a_put(client, path)
  a_request(:put, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end

def a_delete(client, path)
  a_request(:delete, "#{client.endpoint}/#{client.store_hash}/v2/#{path}")
end