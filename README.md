bigcommerce-oauth-api-ruby
==========================
[![Code Climate](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby)

Installation
-------------
The gem is currently under development. For it can be installed by adding the following line to your Gemfile.
```
gem 'bigcommerce-oauth-api', github: 'corthmann/bigcommerce-oauth-api-ruby'
```

Configuration
-------------
The gem can be configured in two ways. Either by initializing the API with certain options.
```
BigcommerceOAuthAPI.configuration do |config|
    config.store_hash = 'YOU STORE ID'
    config.client_id = 'YOUR CLIENT ID'
    config.oauth_token = 'YOUR OAUTH ACCESS TOKEN'
end
```

Or by passing options to a new client instance.
```
BigcommerceOAuthAPI::Client.new(
                                :store_hash => 'YOUR STORE ID',
                                :config.client_id = 'YOUR CLIENT ID',
                                :config.oauth_token = 'YOUR OAUTH ACCESS TOKEN'
                                )
```

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