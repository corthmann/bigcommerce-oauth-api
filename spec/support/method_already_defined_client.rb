require 'bigcommerce-oauth-api'
require 'bigcommerce-oauth-api/api'

class MethodAlreadyDefinedClient < BigcommerceOAuthAPI::API
  with_api_methods :post => { api_module: :post, scope: :self, methods: [:select]}
end
