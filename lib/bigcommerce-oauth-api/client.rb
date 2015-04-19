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
                     :brand => { api_module: :brand, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :category => { api_module: :category, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :customer => { api_module: :customer, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :customer_address => { api_module: :address, scope: :customer, methods: [:all, :select, :create, :update, :delete]},
                     :customer_group => { api_module: :customer_group, scope: :self, methods: [:all, :select, :create, :update, :delete]},
                     :geography_country => { api_module: :country, scope: :self, methods: [:all, :select, :count]},
                     :geography_state => { api_module: :state, scope: :country, methods: [:all, :select, :count]},
                     :marketing_coupons => { api_module: :coupon, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :option => { api_module: :option, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :option_set => { api_module: :option_set, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :option_set_option => { api_module: :option, scope: :option_set, methods: [:all, :select, :create, :update, :delete]},
                     :option_value => { api_module: :value, scope: :option, methods: [:all, :select, :create, :update, :delete]},
                     :order_status => { api_module: :order_status, scope: :self, methods: [:all, :select]},
                     :order => { api_module: :order, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :order_coupon => { api_module: :coupon, scope: :order, methods: [:all, :select]},
                     :order_message => { api_module: :message, scope: :order, methods: [:all, :select]},
                     :order_product => { api_module: :product, scope: :order, methods: [:all, :select, :count]},
                     :order_shipment => { api_module: :shipment, scope: :order, methods: [:all, :select, :create, :update, :delete]},
                     :order_shipping_address => { api_module: :shipping_address, scope: :order, methods: [:all, :select]},
                     :order_taxes => { api_module: :tax, scope: :order, methods: [:all, :select]},
                     :payment_method => { api_module: :method, scope: :self, methods: [:all], prefix_paths: 'payments', prefix_methods: 'payment'},
                     :product => { api_module: :product, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :product_custom_field => { api_module: :custom_field, scope: :product, methods: [:all, :select, :create, :update, :delete]},
                     :product_discount_rule => { api_module: :discount_rule, scope: :product, methods: [:all, :select, :create, :update, :delete, :count]},
                     :product_configurable_field => { api_module: :configurable_field, scope: :product, methods: [:all, :select, :delete, :count]},
                     :product_image => { api_module: :image, scope: :product, methods: [:all, :select, :create, :update, :delete, :count]},
                     :product_option => { api_module: :option, scope: :product, methods: [:all, :select]},
                     :product_review => { api_module: :review, scope: :product, methods: [:all]},
                     :product_rule => { api_module: :rule, scope: :product, methods: [:all, :select, :create, :update, :delete, :count]},
                     :product_video => { api_module: :video, scope: :product, methods: [:all, :select, :create, :update, :delete, :count]},
                     :product_sku => { api_module: :sku, scope: :product, methods: [:all, :select, :create, :update, :delete, :count]},
                     :redirect => { api_module: :redirect, scope: :self, methods: [:all, :select, :create, :update, :delete, :count]},
                     :shipping_method => { api_module: :method, scope: :self, methods: [:all, :select], prefix_paths: 'shipping', prefix_methods: 'shipping'},
                     :tax_class => { api_module: :tax_class, scope: :self, methods: [:all, :select]},
                     :web_hook => { api_module: :hook, scope: :self, methods: [:all, :select, :create, :update, :delete], legacy: false }

    ##
    # :method: blog_posts
    # gets a list of posts
    #
    # :call-seq:
    #   blog_posts(options = {})

    ##
    # :method: blog_post
    # gets the post with the given id
    #
    # :call-seq:
    #   blog_post(id, options = {})

    ##
    # :method: create_blog_post
    # creates a post with the given attributes
    #
    # :call-seq:
    #   create_blog_post(options = {})

    ##
    # :method: update_blog_post
    # update the attributes of the post with the given id
    #
    # :call-seq:
    #   update_blog_post(id, options = {})

    ##
    # :method: delete_blog_post
    # deletes the post with the given id
    #
    # :call-seq:
    #   delete_blog_post(id)

    ##
    # :method: blog_tags
    # gets a list of tags
    #
    # :call-seq:
    #   blog_tags(options = {})

    ##
    # :method: brands
    # gets a list of brands
    #
    # :call-seq:
    #   brands(options = {})

    ##
    # :method: brand
    # gets the brand with the given id
    #
    # :call-seq:
    #   brand(id, options = {})

    ##
    # :method: create_brand
    # creates a brand with the given attributes
    #
    # :call-seq:
    #   create_brand(options = {})

    ##
    # :method: update_brand
    # update the attributes of the brand with the given id
    #
    # :call-seq:
    #   update_brand(id, options = {})

    ##
    # :method: delete_brand
    # deletes the brand with the given id
    #
    # :call-seq:
    #   delete_brand(id)

    ##
    # :method: categories
    # gets a list of categories
    #
    # :call-seq:
    #   categories(options = {})

    ##
    # :method: category
    # gets the category with the given id
    #
    # :call-seq:
    #   category(id, options = {})

    ##
    # :method: create_category
    # creates a category with the given attributes
    #
    # :call-seq:
    #   create_category(options = {})

    ##
    # :method: update_category
    # update the attributes of the category with the given id
    #
    # :call-seq:
    #   update_category(id, options = {})

    ##
    # :method: delete_category
    # deletes the category with the given id
    #
    # :call-seq:
    #   delete_category(id)

    ##
    # :method: customers
    # gets a list of customers
    #
    # :call-seq:
    #   customers(options = {})

    ##
    # :method: customer
    # gets the customer with the given id
    #
    # :call-seq:
    #   customer(id, options = {})

    ##
    # :method: create_customer
    # creates a customer with the given attributes
    #
    # :call-seq:
    #   create_customer(options = {})

    ##
    # :method: update_customer
    # update the attributes of the customer with the given id
    #
    # :call-seq:
    #   update_customer(id, options = {})

    ##
    # :method: delete_customer
    # deletes the customer with the given id
    #
    # :call-seq:
    #   delete_customer(id)

    ##
    # :method: customers_count
    # returns the number of customers
    #
    # :call-seq:
    #   customers_count(options = {})

    ##
    # :method: customer_addresses
    # gets a list of addresses for the given customer
    #
    # :call-seq:
    #   customer_addresses(customer_id, options = {})

    ##
    # :method: customer_address
    # gets the address with the given id for the given customer
    #
    # :call-seq:
    #   customer_address(customer_id, id, options = {})

    ##
    # :method: create_customer_address
    # creates a address with the given attributes for the given customer
    #
    # :call-seq:
    #   create_customer_address(customer_id, options = {})

    ##
    # :method: update_customer_address
    # update the attributes of the address with the given id for the given customer
    #
    # :call-seq:
    #   update_customer_address(customer_id, id, options = {})

    ##
    # :method: delete_customer_address
    # deletes the address with the given id for the given customer
    #
    # :call-seq:
    #   delete_customer_address(customer_id, id)

    ##
    # :method: customer_groups
    # gets a list of customer_groups
    #
    # :call-seq:
    #   customer_groups(options = {})

    ##
    # :method: customer_group
    # gets the customer_group with the given id
    #
    # :call-seq:
    #   customer_group(id, options = {})

    ##
    # :method: create_customer_group
    # creates a customer_group with the given attributes
    #
    # :call-seq:
    #   create_customer_group(options = {})

    ##
    # :method: update_customer_group
    # update the attributes of the customer_group with the given id
    #
    # :call-seq:
    #   update_customer_group(id, options = {})

    ##
    # :method: delete_customer_group
    # deletes the customer_group with the given id
    #
    # :call-seq:
    #   delete_customer_group(id)

    ##
    # :method: countries
    # gets a list of countries
    #
    # :call-seq:
    #   countries(options = {})

    ##
    # :method: country
    # gets the country with the given id
    #
    # :call-seq:
    #   country(id, options = {})

    ##
    # :method: countries_count
    # returns the number of countries
    #
    # :call-seq:
    #   countries_count(options = {})

    ##
    # :method: country_states
    # gets a list of states for the given country
    #
    # :call-seq:
    #   country_states(country_id, options = {})

    ##
    # :method: country_state
    # gets the state with the given id for the given country
    #
    # :call-seq:
    #   country_state(country_id, id, options = {})

    ##
    # :method: country_states_count
    # returns the number of states for the given country
    #
    # :call-seq:
    #   country_states_count(country_id, options = {})

    ##
    # :method: coupons
    # gets a list of coupons
    #
    # :call-seq:
    #   coupons(options = {})

    ##
    # :method: coupon
    # gets the coupon with the given id
    #
    # :call-seq:
    #   coupon(id, options = {})

    ##
    # :method: create_coupon
    # creates a coupon with the given attributes
    #
    # :call-seq:
    #   create_coupon(options = {})

    ##
    # :method: update_coupon
    # update the attributes of the coupon with the given id
    #
    # :call-seq:
    #   update_coupon(id, options = {})

    ##
    # :method: delete_coupon
    # deletes the coupon with the given id
    #
    # :call-seq:
    #   delete_coupon(id)

    ##
    # :method: options
    # gets a list of options
    #
    # :call-seq:
    #   options(options = {})

    ##
    # :method: option
    # gets the option with the given id
    #
    # :call-seq:
    #   option(id, options = {})

    ##
    # :method: create_option
    # creates a option with the given attributes
    #
    # :call-seq:
    #   create_option(options = {})

    ##
    # :method: update_option
    # update the attributes of the option with the given id
    #
    # :call-seq:
    #   update_option(id, options = {})

    ##
    # :method: delete_option
    # deletes the option with the given id
    #
    # :call-seq:
    #   delete_option(id)

    ##
    # :method: option_sets
    # gets a list of option_sets
    #
    # :call-seq:
    #   option_sets(options = {})

    ##
    # :method: option_set
    # gets the option_set with the given id
    #
    # :call-seq:
    #   option_set(id, options = {})

    ##
    # :method: create_option_set
    # creates a option_set with the given attributes
    #
    # :call-seq:
    #   create_option_set(options = {})

    ##
    # :method: update_option_set
    # update the attributes of the option_set with the given id
    #
    # :call-seq:
    #   update_option_set(id, options = {})

    ##
    # :method: delete_option_set
    # deletes the option_set with the given id
    #
    # :call-seq:
    #   delete_option_set(id)

    ##
    # :method: option_set_options
    # gets a list of options for the given option_set
    #
    # :call-seq:
    #   option_set_options(option_set_id, options = {})

    ##
    # :method: option_set_option
    # gets the option with the given id for the given option_set
    #
    # :call-seq:
    #   option_set_option(option_set_id, id, options = {})

    ##
    # :method: create_option_set_option
    # creates a option with the given attributes for the given option_set
    #
    # :call-seq:
    #   create_option_set_option(option_set_id, options = {})

    ##
    # :method: update_option_set_option
    # update the attributes of the option with the given id for the given option_set
    #
    # :call-seq:
    #   update_option_set_option(option_set_id, id, options = {})

    ##
    # :method: delete_option_set_option
    # deletes the option with the given id for the given option_set
    #
    # :call-seq:
    #   delete_option_set_option(option_set_id, id)

    ##
    # :method: option_set_values
    # gets a list of values for the given option_set
    #
    # :call-seq:
    #   option_set_values(option_set_id, options = {})

    ##
    # :method: option_set_value
    # gets the value with the given id for the given option_set
    #
    # :call-seq:
    #   option_set_value(option_set_id, id, options = {})

    ##
    # :method: create_option_set_value
    # creates a value with the given attributes for the given option_set
    #
    # :call-seq:
    #   create_option_set_value(option_set_id, options = {})

    ##
    # :method: update_option_set_value
    # update the attributes of the value with the given id for the given option_set
    #
    # :call-seq:
    #   update_option_set_value(option_set_id, id, options = {})

    ##
    # :method: delete_option_set_value
    # deletes the value with the given id for the given option_set
    #
    # :call-seq:
    #   delete_option_set_value(option_set_id, id)

    ##
    # :method: orders
    # gets a list of orders
    #
    # :call-seq:
    #   orders(options = {})

    ##
    # :method: order
    # gets the order with the given id
    #
    # :call-seq:
    #   order(id, options = {})

    ##
    # :method: create_order
    # creates a order with the given attributes
    #
    # :call-seq:
    #   create_order(options = {})

    ##
    # :method: update_order
    # update the attributes of the order with the given id
    #
    # :call-seq:
    #   update_order(id, options = {})

    ##
    # :method: delete_order
    # deletes the order with the given id
    #
    # :call-seq:
    #   delete_order(id)

    ##
    # :method: orders_count
    # returns the number of orders
    #
    # :call-seq:
    #   orders_count(options = {})

    ##
    # :method: order_messages
    # gets a list of messages for the given order
    #
    # :call-seq:
    #   order_messages(order_id, options = {})

    ##
    # :method: order_message
    # gets the message with the given id for the given order
    #
    # :call-seq:
    #   order_message(order_id, id, options = {})

    ##
    # :method: order_products
    # gets a list of products for the given order
    #
    # :call-seq:
    #   order_products(order_id, options = {})

    ##
    # :method: order_product
    # gets the product with the given id for the given order
    #
    # :call-seq:
    #   order_product(order_id, id, options = {})

    ##
    # :method: order_shipments
    # gets a list of shipments for the given order
    #
    # :call-seq:
    #   order_shipments(order_id, options = {})

    ##
    # :method: order_shipment
    # gets the shipment with the given id for the given order
    #
    # :call-seq:
    #   order_shipment(order_id, id, options = {})

    ##
    # :method: create_order_shipment
    # creates a shipment with the given attributes for the given order
    #
    # :call-seq:
    #   create_order_shipment(order_id, options = {})

    ##
    # :method: update_order_shipment
    # update the attributes of the shipment with the given id for the given order
    #
    # :call-seq:
    #   update_order_shipment(order_id, id, options = {})

    ##
    # :method: delete_order_shipment
    # deletes the shipment with the given id for the given order
    #
    # :call-seq:
    #   delete_order_shipment(order_id, id)

    ##
    # :method: order_shipping_addresses
    # gets a list of shipping_addresses for the given order
    #
    # :call-seq:
    #   order_shipping_addresses(order_id, options = {})

    ##
    # :method: order_shipping_address
    # gets the shipping_address with the given id for the given order
    #
    # :call-seq:
    #   order_shipping_address(order_id, id, options = {})

    ##
    # :method: payment_methods
    # gets a list of methods
    #
    # :call-seq:
    #   payment_methods(options = {})

    ##
    # :method: products
    # gets a list of products
    #
    # :call-seq:
    #   products(options = {})

    ##
    # :method: product
    # gets the product with the given id
    #
    # :call-seq:
    #   product(id, options = {})

    ##
    # :method: create_product
    # creates a product with the given attributes
    #
    # :call-seq:
    #   create_product(options = {})

    ##
    # :method: update_product
    # update the attributes of the product with the given id
    #
    # :call-seq:
    #   update_product(id, options = {})

    ##
    # :method: delete_product
    # deletes the product with the given id
    #
    # :call-seq:
    #   delete_product(id)

    ##
    # :method: products_count
    # returns the number of products
    #
    # :call-seq:
    #   products_count(options = {})

    ##
    # :method: product_custom_fields
    # gets a list of custom_fields for the given product
    #
    # :call-seq:
    #   product_custom_fields(product_id, options = {})

    ##
    # :method: product_custom_field
    # gets the custom_field with the given id for the given product
    #
    # :call-seq:
    #   product_custom_field(product_id, id, options = {})

    ##
    # :method: create_product_custom_field
    # creates a custom_field with the given attributes for the given product
    #
    # :call-seq:
    #   create_product_custom_field(product_id, options = {})

    ##
    # :method: update_product_custom_field
    # update the attributes of the custom_field with the given id for the given product
    #
    # :call-seq:
    #   update_product_custom_field(product_id, id, options = {})

    ##
    # :method: delete_product_custom_field
    # deletes the custom_field with the given id for the given product
    #
    # :call-seq:
    #   delete_product_custom_field(product_id, id)

    ##
    # :method: product_discount_rules
    # gets a list of discount_rules for the given product
    #
    # :call-seq:
    #   product_discount_rules(product_id, options = {})

    ##
    # :method: product_discount_rule
    # gets the discount_rule with the given id for the given product
    #
    # :call-seq:
    #   product_discount_rule(product_id, id, options = {})

    ##
    # :method: create_product_discount_rule
    # creates a discount_rule with the given attributes for the given product
    #
    # :call-seq:
    #   create_product_discount_rule(product_id, options = {})

    ##
    # :method: update_product_discount_rule
    # update the attributes of the discount_rule with the given id for the given product
    #
    # :call-seq:
    #   update_product_discount_rule(product_id, id, options = {})

    ##
    # :method: delete_product_discount_rule
    # deletes the discount_rule with the given id for the given product
    #
    # :call-seq:
    #   delete_product_discount_rule(product_id, id)

    ##
    # :method: product_configurable_fields
    # gets a list of configurable_fields for the given product
    #
    # :call-seq:
    #   product_configurable_fields(product_id, options = {})

    ##
    # :method: product_configurable_field
    # gets the configurable_field with the given id for the given product
    #
    # :call-seq:
    #   product_configurable_field(product_id, id, options = {})

    ##
    # :method: delete_product_configurable_field
    # deletes the configurable_field with the given id for the given product
    #
    # :call-seq:
    #   delete_product_configurable_field(product_id, id)

    ##
    # :method: product_images
    # gets a list of images for the given product
    #
    # :call-seq:
    #   product_images(product_id, options = {})

    ##
    # :method: product_image
    # gets the image with the given id for the given product
    #
    # :call-seq:
    #   product_image(product_id, id, options = {})

    ##
    # :method: create_product_image
    # creates a image with the given attributes for the given product
    #
    # :call-seq:
    #   create_product_image(product_id, options = {})

    ##
    # :method: update_product_image
    # update the attributes of the image with the given id for the given product
    #
    # :call-seq:
    #   update_product_image(product_id, id, options = {})

    ##
    # :method: delete_product_image
    # deletes the image with the given id for the given product
    #
    # :call-seq:
    #   delete_product_image(product_id, id)

    ##
    # :method: product_options
    # gets a list of options for the given product
    #
    # :call-seq:
    #   product_options(product_id, options = {})

    ##
    # :method: product_option
    # gets the option with the given id for the given product
    #
    # :call-seq:
    #   product_option(product_id, id, options = {})

    ##
    # :method: product_reviews
    # gets a list of reviews for the given product
    #
    # :call-seq:
    #   product_reviews(product_id, options = {})

    ##
    # :method: product_rules
    # gets a list of rules for the given product
    #
    # :call-seq:
    #   product_rules(product_id, options = {})

    ##
    # :method: product_rule
    # gets the rule with the given id for the given product
    #
    # :call-seq:
    #   product_rule(product_id, id, options = {})

    ##
    # :method: create_product_rule
    # creates a rule with the given attributes for the given product
    #
    # :call-seq:
    #   create_product_rule(product_id, options = {})

    ##
    # :method: update_product_rule
    # update the attributes of the rule with the given id for the given product
    #
    # :call-seq:
    #   update_product_rule(product_id, id, options = {})

    ##
    # :method: delete_product_rule
    # deletes the rule with the given id for the given product
    #
    # :call-seq:
    #   delete_product_rule(product_id, id)

    ##
    # :method: product_videos
    # gets a list of videos for the given product
    #
    # :call-seq:
    #   product_videos(product_id, options = {})

    ##
    # :method: product_video
    # gets the video with the given id for the given product
    #
    # :call-seq:
    #   product_video(product_id, id, options = {})

    ##
    # :method: create_product_video
    # creates a video with the given attributes for the given product
    #
    # :call-seq:
    #   create_product_video(product_id, options = {})

    ##
    # :method: update_product_video
    # update the attributes of the video with the given id for the given product
    #
    # :call-seq:
    #   update_product_video(product_id, id, options = {})

    ##
    # :method: delete_product_video
    # deletes the video with the given id for the given product
    #
    # :call-seq:
    #   delete_product_video(product_id, id)

    ##
    # :method: product_skus
    # gets a list of skus for the given product
    #
    # :call-seq:
    #   product_skus(product_id, options = {})

    ##
    # :method: product_sku
    # gets the sku with the given id for the given product
    #
    # :call-seq:
    #   product_sku(product_id, id, options = {})

    ##
    # :method: create_product_sku
    # creates a sku with the given attributes for the given product
    #
    # :call-seq:
    #   create_product_sku(product_id, options = {})

    ##
    # :method: update_product_sku
    # update the attributes of the sku with the given id for the given product
    #
    # :call-seq:
    #   update_product_sku(product_id, id, options = {})

    ##
    # :method: delete_product_sku
    # deletes the sku with the given id for the given product
    #
    # :call-seq:
    #   delete_product_sku(product_id, id)

    ##
    # :method: redirects
    # gets a list of redirects
    #
    # :call-seq:
    #   redirects(options = {})

    ##
    # :method: redirect
    # gets the redirect with the given id
    #
    # :call-seq:
    #   redirect(id, options = {})

    ##
    # :method: create_redirect
    # creates a redirect with the given attributes
    #
    # :call-seq:
    #   create_redirect(options = {})

    ##
    # :method: update_redirect
    # update the attributes of the redirect with the given id
    #
    # :call-seq:
    #   update_redirect(id, options = {})

    ##
    # :method: delete_redirect
    # deletes the redirect with the given id
    #
    # :call-seq:
    #   delete_redirect(id)

    ##
    # :method: shipping_methods
    # gets a list of methods
    #
    # :call-seq:
    #   shipping_methods(options = {})

    ##
    # :method: shipping_method
    # gets the method with the given id
    #
    # :call-seq:
    #   shipping_method(id, options = {})

    ##
    # :method: tax_classes
    # gets a list of tax_classes
    #
    # :call-seq:
    #   tax_classes(options = {})

    ##
    # :method: tax_class
    # gets the tax_class with the given id
    #
    # :call-seq:
    #   tax_class(id, options = {})

    ##
    # :method: hooks
    # gets a list of hooks
    #
    # :call-seq:
    #   hooks(options = {})

    ##
    # :method: hook
    # gets the hook with the given id
    #
    # :call-seq:
    #   hook(id, options = {})

    ##
    # :method: create_hook
    # creates a hook with the given attributes
    #
    # :call-seq:
    #   create_hook(options = {})

    ##
    # :method: update_hook
    # update the attributes of the hook with the given id
    #
    # :call-seq:
    #   update_hook(id, options = {})

    ##
    # :method: delete_hook
    # deletes the hook with the given id
    #
    # :call-seq:
    #   delete_hook(id)

  end
end