### 1.2.1 (2015-05-13)

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
