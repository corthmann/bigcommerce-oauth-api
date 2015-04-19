require 'simplecov'
require 'simplecov-rcov'
require 'codeclimate-test-reporter'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::RcovFormatter,
    CodeClimate::TestReporter::Formatter
  ]
  add_group('BigcommerceOAuthAPI', 'lib/bigcommerce-oauth-api')
  add_group('Faraday', 'lib/faraday')
  add_group('Specs', 'spec')
end

require 'bigcommerce-oauth-api'

require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

WebMock.disable_net_connect!(:allow => 'codeclimate.com')

def client_request_url(client, path)
  if client.is_legacy?
    protocol, domain = client.endpoint.split('://')
    "#{protocol}://#{client.user_name}:#{client.api_key}@#{domain}/api/v2/#{path}"
  else
    "#{client.endpoint}/#{client.store_hash}/v2/#{path}"
  end
end

def stub_get(client, path)
  stub_request(:get, client_request_url(client, path))
end

def stub_post(client, path)
  stub_request(:post, client_request_url(client, path))
end

def stub_put(client, path)
  stub_request(:put, client_request_url(client, path))
end

def stub_delete(client, path)
  stub_request(:delete, client_request_url(client, path))
end

def a_get(client, path)
  a_request(:get, client_request_url(client, path))
end

def a_post(client, path)
  a_request(:post, client_request_url(client, path))
end

def a_put(client, path)
  a_request(:put, client_request_url(client, path))
end

def a_delete(client, path)
  a_request(:delete, client_request_url(client, path))
end