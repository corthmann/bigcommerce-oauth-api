require 'bigcommerce_oauth_api/api'

module BigcommerceOAuthAPI
  class Client < API

    def time
      get('time')
    end

    def store_information
      get('store')
    end

    def product_googleproductsearch(product_id, options = {})
      get("products/#{product_id}/googleproductsearch", options)
    end

    with_api_methods :blog_post => { api_module: :post, scope: :self, methods: [:all, :select, :create, :update, :delete], prefix_paths: 'blog', prefix_methods: 'blog'},
                     :blog_tag => { api_module: :tag, scope: :self, methods: [:all], prefix_paths: 'blog', prefix_methods: 'blog'},
                     :brand => { api_module: :brand, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :category => { api_module: :category, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :customer => { api_module: :customer, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :customer_address => { api_module: :address, scope: :customer, methods: [:all, :select, :create, :update, :delete]},
                     :customer_group => { api_module: :customer_group, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :geography_country => { api_module: :country, scope: :self, methods: [:all, :select]},
                     :geography_state => { api_module: :state, scope: :self, methods: [:all, :select]},
                     :marketing_coupons => { api_module: :coupon, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :option => { api_module: :option, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :option_set => { api_module: :option_set, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :option_set_option => { api_module: :option, scope: :option_set, methods: [:all, :select, :create, :update, :delete]},
                     :option_set_value => { api_module: :value, scope: :option_set, methods: [:all, :select, :create, :update, :delete]},
                     :order => { api_module: :order, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :order_message => { api_module: :message, scope: :order, methods: [:all, :select]},
                     :order_product => { api_module: :product, scope: :order, methods: [:all, :select]},
                     :order_shipment => { api_module: :shipment, scope: :order, methods: [:all, :select, :create, :update, :delete]},
                     :order_shipping_address => { api_module: :shipping_address, scope: :order, methods: [:all, :select]},
                     :payment_method => { api_module: :method, scope: :self, methods: [:all], prefix_paths: 'payments', prefix_methods: 'payment'},
                     :product => { api_module: :product, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :product_custom_field => { api_module: :custom_field, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :product_discount_rule => { api_module: :discount_rule, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :product_configurable_field => { api_module: :configurable_field, scope: :product, methods: [:all, :select, :delete]},
                     :product_image => { api_module: :image, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :product_option => { api_module: :option, scope: :product, methods: [:all, :select]},
                     :product_review => { api_module: :review, scope: :product, methods: [:all]},
                     :product_rule => { api_module: :rule, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :product_video => { api_module: :video, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :product_sku => { api_module: :sku, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :redirect => { api_module: :redirect, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :shipping_method => { api_module: :method, scope: :self, methods: [:all, :select], prefix_paths: 'shipping', prefix_methods: 'shipping'},
                     :tax_class => { api_module: :tax_class, scope: :self, methods: [:all, :select]},
                     :web_hook => { api_module: :hook, scope: :self, methods: [:all, :select, :create, :update, :delete]}

  end
end