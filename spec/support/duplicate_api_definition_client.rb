require 'bigcommerce-oauth-api'
require 'bigcommerce-oauth-api/api'

class DuplicateApiDefinitionClient < BigcommerceOAuthAPI::API
  with_api_methods :state => { api_module: :state, scope: :self, methods: [:all, :select]},
                   :geography_state => { api_module: :state, scope: :self, methods: [:all, :select]}
end