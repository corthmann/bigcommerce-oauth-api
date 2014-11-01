require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/api'

class MethodAlreadyDefinedClient < BigcommerceOAuthAPI::API
  with_api_methods :post => { api_module: :post, scope: :self, methods: [:select]}
end