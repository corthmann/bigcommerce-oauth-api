bigcommerce-oauth-api-ruby
==========================
[![Code Climate](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/corthmann/bigcommerce-oauth-api-ruby)

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
                                :config.client_id = 'YOUR CLIENT ID'
                                :config.oauth_token = 'YOUR OAUTH ACCESS TOKEN'
                                )
```