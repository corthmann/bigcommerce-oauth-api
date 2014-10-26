require 'bigcommerce_oauth_api'

module BigcommerceOAuthAPI
  class Error < StandardError
    include Wrest::Components::Container
    always_has :message
    typecast :code => as_integer

    def inspect
      "#<BigcommerceOAuthAPI::Error: BigcommerceOAuthAPI::Error message=\"#{message}\">"
    end
  end

end