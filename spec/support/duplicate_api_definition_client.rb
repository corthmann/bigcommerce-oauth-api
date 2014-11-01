require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/api'

class DuplicateApiDefinitionClient < BigcommerceOAuthAPI::API
  with_api_methods :state => { api_module: :state, scope: :self, methods: [:all, :select]},
                   :geography_state => { api_module: :state, scope: :self, methods: [:all, :select]}
end