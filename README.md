bigcommerce-oauth-api
==========================
[![Gem Version](https://badge.fury.io/rb/bigcommerce-oauth-api.svg)](http://badge.fury.io/rb/bigcommerce-oauth-api)
[![Code Climate](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby)
[![Test Coverage](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby/badges/coverage.svg)](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby)
[![Dependency Status](https://gemnasium.com/corthmann/bigcommerce-oauth-api-ruby.svg)](https://gemnasium.com/corthmann/bigcommerce-oauth-api-ruby)

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
The gem can be configured in two ways. Either by initializing the API with certain options.
```
BigcommerceOAuthAPI.configuration do |config|
    config.store_hash = 'YOU STORE ID'
    config.client_id = 'YOUR CLIENT ID'
    config.access_token = 'YOUR OAUTH ACCESS TOKEN'
end
```

Or by passing options to a new client instance.
```
api = BigcommerceOAuthAPI::Client.new(
                                :store_hash => 'YOUR STORE ID',
                                :config.client_id => 'YOUR CLIENT ID',
                                :config.access_token => 'YOUR OAUTH ACCESS TOKEN'
                                )
```

Using the API
-------------
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
All resource attributes can be accessed both using methods or as a hash with keys as either strings or keys.
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

API | Included from
--- | ---
blog post | 1.0.2
blog tag | 1.0.2
brand api | 1.1.0
bulk pricing (discount rules) | 1.1.0
category | 1.1.0
customer api | 1.0.2
customer address | 1.0.2
customer group | 1.0.2
geography country | 1.0.2
geography state | 1.0.2
marketing coupon | 1.0.2
option | 1.1.0
option set | 1.1.0
option set option | 1.1.0
option set value | 1.1.0
order | 1.0.2
order message | 1.0.2
order product | 1.0.2
order shipment | 1.0.2
order shipping address | 1.0.2
payment method | 1.0.2
product | 1.0.2
product configurable field | 1.1.0
product custom field | 1.0.2
product googleproductsearch | 1.1.0
product image | 1.1.0
product option | 1.1.0
product review | 1.1.0
product rules | 1.1.0
product video | 1.1.0
product SKU | 1.1.0
redirect | 1.0.2
shipping method api | 1.0.2
store information | 1.0.2
system (time) | 1.0.2
tax class | 1.0.2
web hook | 1.0.2

Getting an OAuth Access Token
-------------
Currently the Bigcommerce API is only focused on making the OAuth API available for 3rd party development through Apps.
This is quite frustrating especially if you want to use the API to make custom integrations for your webshop.

However, it is actually possible to aquire access tokens without publishing an App for Bigcommerce.

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