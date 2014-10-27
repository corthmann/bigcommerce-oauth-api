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