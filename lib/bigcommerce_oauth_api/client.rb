require 'bigcommerce_oauth_api/api'

module BigcommerceOAuthAPI
  class Client < API
    with_api_methods :product => { api_module: :product, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :product_custom_field => { api_module: :custom_field, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :order => { api_module: :order, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :order_product => { api_module: :product, scope: :order, methods: [:all, :select]},
                     :order_shipping_address => { api_module: :shipping_address, scope: :order, methods: [:all, :select]},
                     :order_message => { api_module: :message, scope: :order, methods: [:all, :select]},
                     :order_shipment => { api_module: :shipment, scope: :order, methods: [:all, :select, :create, :update, :delete]}

  end
end