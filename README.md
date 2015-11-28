bigcommerce-oauth-api
==========================
[![Gem Version](https://badge.fury.io/rb/bigcommerce-oauth-api.svg)](http://badge.fury.io/rb/bigcommerce-oauth-api)
[![Code Climate](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api/badges/gpa.svg)](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api)
[![Test Coverage](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api/badges/coverage.svg)](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api)
[![Dependency Status](https://gemnasium.com/corthmann/bigcommerce-oauth-api.svg)](https://gemnasium.com/corthmann/bigcommerce-oauth-api)

This gem provides a wrapper for the Bigcommerce REST API.

Installation
-------------
You can install this gem by using the following command:
```
gem install bigcommerce-oauth-api
```
or by adding the the following line to your Gemfile.
```
gem 'bigcommerce-oauth-api'
```

Configuration
-------------
The gem can be configured either by module or class configuration. Starting from v1.2.0 `bigcommerce-oauth-api` supports both OAuth and legacy authentication.
```
# module oauth configuration
BigcommerceOAuthAPI.configuration do |config|
    config.store_hash = 'YOU STORE ID'
    config.client_id = 'YOUR CLIENT ID'
    config.access_token = 'YOUR OAUTH ACCESS TOKEN'
end

# module legacy (basic auth) configuration
BigcommerceOAuthAPI.configuration do |config|
    config.endpoint = 'YOU STORE URL (https://store-XYZ.mybigcommerce.com)'
    config.user_name = 'API USER NAME'
    config.api_key = 'API KEY'
end

# class oauth configuration
api = BigcommerceOAuthAPI::Client.new(
                                :store_hash => 'YOUR STORE ID',
                                :client_id => 'YOUR CLIENT ID',
                                :access_token => 'YOUR OAUTH ACCESS TOKEN'
                                )

# class legacy (basic auth) configuration
api = BigcommerceOAuthAPI::Client.new(
                                :endpoint => 'YOU STORE URL (ex. https://store-XYZ.mybigcommerce.com)',
                                :user_name => 'API USER NAME',
                                :api_key => 'API KEY'
                                )
```

Starting from v1.2.1 `bigcommerce-oauth-api` supports the `If-Modified-Since` header described on https://developer.bigcommerce.com/api/req-headers. As all other configurations, the header can be set with both module and instance configuration using the key `if_modified_since`.

Starting from v1.3.0 `bigcommerce-oauth-api` allows you to opt-out of using `BigcommerceOAuthAPI::Resource` through the `typecast_to_resource` configuration. Setting this configuration to `false` ensures that any response object will be of type `Hash` instead of `BigcommerceOAuthAPI::Resource`.

Using the API
-------------
It is recommended to use this documentation in combination the official api documentation on https://developer.bigcommerce.com/api/

Get a list of products:
```
products = api.products
```
Get orders with order_id >= 100
```
orders = api.orders({ min_id: 100 })
```
Get the order with id = 101
```
order = api.order(101)
```
All resource attributes can be accessed both using methods or as a hash with keys as either strings or symbols.
```
# each of the following lines return the first name listed in the order billing address
order.billing_address.first_name
order['billing_address']['first_name']
order[:billing_address][:first_name]
```
Update the name of a customer
```
customer = api.update_customer(101, {first_name: 'Christian'})
```
Delete an order shipment
```
order_id = 101
shipment_id = 1000
api.delete_order_shipment(order_id, shipment_id)
```

Webhooks
-------------
In many applications it is an advantage to receive a callback on events rather than polling information. Such callbacks are commonly called webhooks.

The Bigcommerce API allows you to create webhooks for events you want to respond to - for instance every time an order is created.
```
# more information on: https://developer.bigcommerce.com/api/webhooks-getting-started
new_hook = {
    scope: "store/order/created",
    destination: "https://app.example.com/order-callback",
    is_active: true
}
hook = api.create_hook(new_hook)
```
After creating the webhook as shown above a callback (POST) will be sent to 'https://app.example.com/order-callback' every time an order is created.

The API also allows you to mange hooks like so:
```
# get a list of the webhooks
hooks = api.hooks
# get the webhook with id = 1234
hook_id = 1234
hook = api.hook(hook_id)
# delete the webhook with id = 1234
api.delete_hook(hook_id)
```

API Support
-------------
The following APIs are currently supported:

API | Gem Version | Official Documentation
--- | --- | ---
blog post | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/blog/posts
blog tag | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/blog/tags
brand api | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/brands
bulk pricing (discount rules) | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/discount_rules
category | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/categories
customer api | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/customers
customer address | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/customers/addresses
customer group | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/customer_groups
geography country | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/countries
geography state | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/countries/states
marketing coupon | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/coupons
option | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/options
option set | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/option_sets
option set option | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/option_sets/options
option value | 1.2.0 | https://developer.bigcommerce.com/api/stores/v2/options/values
order | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/orders
order coupon | 1.2.0 | https://developer.bigcommerce.com/api/stores/v2/orders/coupons
order message | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/orders/messages
order product | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/orders/products
order shipment | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/orders/shipments
order shipping address | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/orders/shipping_addresses
order statuses | 1.2.0 | https://developer.bigcommerce.com/api/stores/v2/order_statuses
order tax | 1.2.0 | https://developer.bigcommerce.com/api/stores/v2/orders/taxes
payment method | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/payments/methods
product | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/products
product configurable field | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/configurable_fields
product custom field | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/products/custom_fields
product googleproductsearch | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/googleproductsearch
product image | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/images
product option | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/options
product review | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/reviews
product rules | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/rules
product video | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/videos
product SKU | 1.1.0 | https://developer.bigcommerce.com/api/stores/v2/products/skus
redirect | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/redirects
shipping method api | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/shipping/methods
store information | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/store_information
system (time) | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/time
tax class | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/tax_classes
web hook | 1.0.2 | https://developer.bigcommerce.com/api/stores/v2/webhooks

Getting an OAuth Access Token
-------------
The Bigcommerce API focused on making OAuth available for 3rd party development through Apps.
Bigcommerce currently recommends using basic authentication when developing custom (private) integrations for your webshop.

However, it is actually possible to aquire access tokens without publishing an App for Bigcommerce by following these steps:

1.  Go to http://developer.bigcommerce.com

2.  Login with the same user as the webshop you want to create a token for.

3.  Go to "My Apps" and create dummy app (maybe call it "Authentication App")

4.  Select the APIs you need and set the Auth Callback Url.
    * This needs to be a HTTPS Url where you can read incomming GET request

5.  Go to your webshop and click on "Apps"

6.  Select the tab "My Drafts" (which should contain your "Authentication App")

7.  Install the "Authentication App" in your webshop.
    * This triggers a callback to your "Auth Callback Url" where you receive a code which can be exchanged for a token.

8.  Send a POST request containing the following parameters (to https://login.bigcommerce.com/oauth2/token):
    * client_id (can be found under "My Apps" at developer.bigcommerce.com
    * client_secret (can be found under "My Apps" at developer.bigcommerce.com
    * code (is received in the "Auth Callback")
    * scope (is received in the "Auth Callback")
    * grant_type (is always authorization_code)
    * redirect_uri (your "Auth Callback Url")
    * context (is "stores/{your store hash / id}")

9.  Done! The response returns your OAuth Access Token.

If you are experiencing problems with the POST call try using the folllowing curl command
```
curl --data "[YOUR POST PARAMETERS]" https://login.bigcommerce.com/oauth2/token
```
