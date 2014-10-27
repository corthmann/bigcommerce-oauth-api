require 'simplecov'
require 'bigcommerce_oauth_api'

SimpleCov.start

require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end