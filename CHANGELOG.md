### 1.4.1 (2017-05-18)

Features:
    - added shipping zone api
    - fixed shipping method api

### 1.4.0 (2016-10-09)

Features:

    - added banner apis
    - added gift certificate apis
    - enable BigcommerceOAuthAPI::Resource to set attributes through methods (ex. resource.attribute_name = 'abc')
    - add .to_h method on BigcommerceOAuthAPI::Error. This method will parse the json error message and return it as a hash.

Bugfixes:

    - enable BigcommerceOAuthAPI::Resource to convert array attributes to arrays of BigcommerceOAuthAPI::Resource.

Deprecation warnings added:

    - config.if_modified_since will be removed in v2.0.0
    - config.format will be removed in v2.0.0

### 1.3.2 (2016-01-14)

Bugfixes:

    - enable BigcommerceOAuthAPI::Resource to marshal correctly.
    - add missing 'include_all' option on BigcommerceOAuthAPI::Resource#respond_to?.

### 1.3.1 (2015-11-29)

Bugfixes:

    - increase timeout configuration defaults.

### 1.3.0 (2015-11-28)

Features:

    - added configuration to opt-out of using BigcommerceOAuthAPI::Resource.
    - added configuration to set faraday timeout options.
    - remove omniref and revert to using yard documentation.

Bugfixes:

    - add handling of Bandwidth Limit Exceeded errors.

### 1.2.1 (2015-05-14)

Features:

    - added support for 'If-Modified-Since' requests.

Bugfixes:

    - PUT/POST as json with content-type headers.

### 1.2.0 (2015-04-19)

Features:

    - add legacy api support
    - add omniref and revert to using rdoc
    - add order coupon apis
    - add order tax apis
    - add order statuses apis

Bugfixes:

    - update geography apis
    - add a few missing "count" apis
    - fix option value api
    - update docs

### 1.1.5 (2014-12-25)

Features:

    - add yard documentation

### 1.1.4 (2014-11-10)

Bugfixes:

    - add the missing error codes returned from the Bigcommerce API

### 1.1.3 (2014-11-05)

Bugfixes:

    - return nil on HTTP 204
    - make Resource objects comparable using .eql? and ==
    - add rdoc markup for dynamically added methods

### 1.1.2 (2014-11-04)

Bugfixes:

    - fix broken gemspec
    - remove Gemfile.lock from git and add it to gitignore

### 1.1.1 (2014-11-04)

Bugfixes:

    - correct lib folder name and adjust require statements
    - rename repository from bigcommerce-oauth-api-ruby to bugcommerce-oauth-api
    - update markdown badges


### 1.1.0 (2014-11-02)

Features:

    - add product SKU api
    - add product video api
    - add product rules api
    - add product review api
    - add product option api
    - add product image api
    - add option api
    - add option set api
    - add option set option api
    - add option set value api
    - add googleproductsearch api
    - add product configurable field api
    - add category api
    - add bulk pricing (discount rules) api
    - add brand api
    
    
### 1.0.3 (2014-11-02)

Bugfixes:

    - Change activesupport dependency to >=3 && <5

### 1.0.2 (2014-11-01)

Features:

    - add blog post api
    - add blog tag api
    - add customer api
    - add customer address api
    - add customer group api
    - add geography country api
    - add geography state api
    - add marketing coupon api
    - add order api
    - add order message api
    - add order product api
    - add order shipment api
    - add order shipping address api
    - add payment method api
    - add product api
    - add product custom field api
    - add redirect api
    - add shipping method api
    - add store api (store information)
    - add system api (time)
    - add tax class api
    - add web hook api
