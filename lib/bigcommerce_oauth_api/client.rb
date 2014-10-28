require 'bigcommerce_oauth_api/api'

module BigcommerceOAuthAPI
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include Product
    include Order
  end
end