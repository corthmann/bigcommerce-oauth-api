require 'bigcommerce-oauth-api/api'

module BigcommerceOAuthAPI
  class Client < API

    ##
    # get server time
    def time
      get('time')
    end

    ##
    # get basic store information
    def store_information
      get('store')
    end

    ##
    # Gets the Google Product Search mappings for a product.
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
                     :geography_country => { api_module: :country, scope: :self, methods: [:all, :select, :count]},
                     :geography_state => { api_module: :state, scope: :country, methods: [:all, :select, :count]},
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
                     :web_hook => { api_module: :hook, scope: :self, methods: [:all, :select, :create, :update, :delete], legacy: false }

    # @!method blog_posts(options = {})
    # gets a list of posts

    # @!method blog_post(id, options = {})
    # gets the post with the given id

    # @!method create_blog_post(options = {})
    # creates a post with the given attributes

    # @!method update_blog_post(id, options = {})
    # updates a post with the given attributes

    # @!method delete_blog_post(id)
    # deletes the post with the given id

    # @!method blog_tags(options = {})
    # gets a list of tags

    # @!method brands(options = {})
    # gets a list of brands

    # @!method brand(id, options = {})
    # gets the brand with the given id

    # @!method create_brand(options = {})
    # creates a brand with the given attributes

    # @!method update_brand(id, options = {})
    # updates a brand with the given attributes

    # @!method delete_brand(id)
    # deletes the brand with the given id

    # @!method categories(options = {})
    # gets a list of categories

    # @!method category(id, options = {})
    # gets the category with the given id

    # @!method create_category(options = {})
    # creates a category with the given attributes

    # @!method update_category(id, options = {})
    # updates a category with the given attributes

    # @!method delete_category(id)
    # deletes the category with the given id

    # @!method customers(options = {})
    # gets a list of customers

    # @!method customer(id, options = {})
    # gets the customer with the given id

    # @!method create_customer(options = {})
    # creates a customer with the given attributes

    # @!method update_customer(id, options = {})
    # updates a customer with the given attributes

    # @!method delete_customer(id)
    # deletes the customer with the given id

    # @!method customers_count(options = {})
    # counts the number of customers

    # @!method customer_addresses(customer_id, options = {})
    # gets a list of addresses for the given customer

    # @!method customer_address(customer_id, id, options = {})
    # gets the address with the given id for the given customer

    # @!method create_customer_address(customer_id, options = {})
    # creates a address with the given attributes for the given customer

    # @!method update_customer_address(customer_id, id, options = {})
    # updates a address with the given attributes for the given customer

    # @!method delete_customer_address(customer_id, id)
    # deletes the address with the given id for the given customer

    # @!method customer_groups(options = {})
    # gets a list of customer_groups

    # @!method customer_group(id, options = {})
    # gets the customer_group with the given id

    # @!method create_customer_group(options = {})
    # creates a customer_group with the given attributes

    # @!method update_customer_group(id, options = {})
    # updates a customer_group with the given attributes

    # @!method delete_customer_group(id)
    # deletes the customer_group with the given id

    # @!method countries(options = {})
    # gets a list of countries

    # @!method country(id, options = {})
    # gets the country with the given id

    # @!method states(options = {})
    # gets a list of states

    # @!method state(id, options = {})
    # gets the state with the given id

    # @!method coupons(options = {})
    # gets a list of coupons

    # @!method coupon(id, options = {})
    # gets the coupon with the given id

    # @!method create_coupon(options = {})
    # creates a coupon with the given attributes

    # @!method update_coupon(id, options = {})
    # updates a coupon with the given attributes

    # @!method delete_coupon(id)
    # deletes the coupon with the given id

    # @!method options(options = {})
    # gets a list of options

    # @!method option(id, options = {})
    # gets the option with the given id

    # @!method create_option(options = {})
    # creates a option with the given attributes

    # @!method update_option(id, options = {})
    # updates a option with the given attributes

    # @!method delete_option(id)
    # deletes the option with the given id

    # @!method option_sets(options = {})
    # gets a list of option_sets

    # @!method option_set(id, options = {})
    # gets the option_set with the given id

    # @!method create_option_set(options = {})
    # creates a option_set with the given attributes

    # @!method update_option_set(id, options = {})
    # updates a option_set with the given attributes

    # @!method delete_option_set(id)
    # deletes the option_set with the given id

    # @!method option_set_options(option_set_id, options = {})
    # gets a list of options for the given option_set

    # @!method option_set_option(option_set_id, id, options = {})
    # gets the option with the given id for the given option_set

    # @!method create_option_set_option(option_set_id, options = {})
    # creates a option with the given attributes for the given option_set

    # @!method update_option_set_option(option_set_id, id, options = {})
    # updates a option with the given attributes for the given option_set

    # @!method delete_option_set_option(option_set_id, id)
    # deletes the option with the given id for the given option_set

    # @!method option_set_values(option_set_id, options = {})
    # gets a list of values for the given option_set

    # @!method option_set_value(option_set_id, id, options = {})
    # gets the value with the given id for the given option_set

    # @!method create_option_set_value(option_set_id, options = {})
    # creates a value with the given attributes for the given option_set

    # @!method update_option_set_value(option_set_id, id, options = {})
    # updates a value with the given attributes for the given option_set

    # @!method delete_option_set_value(option_set_id, id)
    # deletes the value with the given id for the given option_set

    # @!method orders(options = {})
    # gets a list of orders

    # @!method order(id, options = {})
    # gets the order with the given id

    # @!method create_order(options = {})
    # creates a order with the given attributes

    # @!method update_order(id, options = {})
    # updates a order with the given attributes

    # @!method delete_order(id)
    # deletes the order with the given id

    # @!method orders_count(options = {})
    # counts the number of orders

    # @!method order_messages(order_id, options = {})
    # gets a list of messages for the given order

    # @!method order_message(order_id, id, options = {})
    # gets the message with the given id for the given order

    # @!method order_products(order_id, options = {})
    # gets a list of products for the given order

    # @!method order_product(order_id, id, options = {})
    # gets the product with the given id for the given order

    # @!method order_shipments(order_id, options = {})
    # gets a list of shipments for the given order

    # @!method order_shipment(order_id, id, options = {})
    # gets the shipment with the given id for the given order

    # @!method create_order_shipment(order_id, options = {})
    # creates a shipment with the given attributes for the given order

    # @!method update_order_shipment(order_id, id, options = {})
    # updates a shipment with the given attributes for the given order

    # @!method delete_order_shipment(order_id, id)
    # deletes the shipment with the given id for the given order

    # @!method order_shipping_addresses(order_id, options = {})
    # gets a list of shipping_addresses for the given order

    # @!method order_shipping_address(order_id, id, options = {})
    # gets the shipping_address with the given id for the given order

    # @!method payment_methods(options = {})
    # gets a list of methods

    # @!method products(options = {})
    # gets a list of products

    # @!method product(id, options = {})
    # gets the product with the given id

    # @!method create_product(options = {})
    # creates a product with the given attributes

    # @!method update_product(id, options = {})
    # updates a product with the given attributes

    # @!method delete_product(id)
    # deletes the product with the given id

    # @!method products_count(options = {})
    # counts the number of products

    # @!method product_custom_fields(product_id, options = {})
    # gets a list of custom_fields for the given product

    # @!method product_custom_field(product_id, id, options = {})
    # gets the custom_field with the given id for the given product

    # @!method create_product_custom_field(product_id, options = {})
    # creates a custom_field with the given attributes for the given product

    # @!method update_product_custom_field(product_id, id, options = {})
    # updates a custom_field with the given attributes for the given product

    # @!method delete_product_custom_field(product_id, id)
    # deletes the custom_field with the given id for the given product

    # @!method product_discount_rules(product_id, options = {})
    # gets a list of discount_rules for the given product

    # @!method product_discount_rule(product_id, id, options = {})
    # gets the discount_rule with the given id for the given product

    # @!method create_product_discount_rule(product_id, options = {})
    # creates a discount_rule with the given attributes for the given product

    # @!method update_product_discount_rule(product_id, id, options = {})
    # updates a discount_rule with the given attributes for the given product

    # @!method delete_product_discount_rule(product_id, id)
    # deletes the discount_rule with the given id for the given product

    # @!method product_configurable_fields(product_id, options = {})
    # gets a list of configurable_fields for the given product

    # @!method product_configurable_field(product_id, id, options = {})
    # gets the configurable_field with the given id for the given product

    # @!method delete_product_configurable_field(product_id, id)
    # deletes the configurable_field with the given id for the given product

    # @!method product_images(product_id, options = {})
    # gets a list of images for the given product

    # @!method product_image(product_id, id, options = {})
    # gets the image with the given id for the given product

    # @!method create_product_image(product_id, options = {})
    # creates a image with the given attributes for the given product

    # @!method update_product_image(product_id, id, options = {})
    # updates a image with the given attributes for the given product

    # @!method delete_product_image(product_id, id)
    # deletes the image with the given id for the given product

    # @!method product_options(product_id, options = {})
    # gets a list of options for the given product

    # @!method product_option(product_id, id, options = {})
    # gets the option with the given id for the given product

    # @!method product_reviews(product_id, options = {})
    # gets a list of reviews for the given product

    # @!method product_rules(product_id, options = {})
    # gets a list of rules for the given product

    # @!method product_rule(product_id, id, options = {})
    # gets the rule with the given id for the given product

    # @!method create_product_rule(product_id, options = {})
    # creates a rule with the given attributes for the given product

    # @!method update_product_rule(product_id, id, options = {})
    # updates a rule with the given attributes for the given product

    # @!method delete_product_rule(product_id, id)
    # deletes the rule with the given id for the given product

    # @!method product_videos(product_id, options = {})
    # gets a list of videos for the given product

    # @!method product_video(product_id, id, options = {})
    # gets the video with the given id for the given product

    # @!method create_product_video(product_id, options = {})
    # creates a video with the given attributes for the given product

    # @!method update_product_video(product_id, id, options = {})
    # updates a video with the given attributes for the given product

    # @!method delete_product_video(product_id, id)
    # deletes the video with the given id for the given product

    # @!method product_skus(product_id, options = {})
    # gets a list of skus for the given product

    # @!method product_sku(product_id, id, options = {})
    # gets the sku with the given id for the given product

    # @!method create_product_sku(product_id, options = {})
    # creates a sku with the given attributes for the given product

    # @!method update_product_sku(product_id, id, options = {})
    # updates a sku with the given attributes for the given product

    # @!method delete_product_sku(product_id, id)
    # deletes the sku with the given id for the given product

    # @!method redirects(options = {})
    # gets a list of redirects

    # @!method redirect(id, options = {})
    # gets the redirect with the given id

    # @!method create_redirect(options = {})
    # creates a redirect with the given attributes

    # @!method update_redirect(id, options = {})
    # updates a redirect with the given attributes

    # @!method delete_redirect(id)
    # deletes the redirect with the given id

    # @!method shipping_methods(options = {})
    # gets a list of methods

    # @!method shipping_method(id, options = {})
    # gets the method with the given id

    # @!method tax_classes(options = {})
    # gets a list of tax_classes

    # @!method tax_class(id, options = {})
    # gets the tax_class with the given id

    # @!method hooks(options = {})
    # gets a list of hooks

    # @!method hook(id, options = {})
    # gets the hook with the given id

    # @!method create_hook(options = {})
    # creates a hook with the given attributes

    # @!method update_hook(id, options = {})
    # updates a hook with the given attributes

    # @!method delete_hook(id)
    # deletes the hook with the given id

  end
end