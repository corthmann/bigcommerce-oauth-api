require 'bigcommerce_oauth_api/connection'
require 'bigcommerce_oauth_api/request'

module BigcommerceOAuthAPI
  class API
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options = {})
      merged_options = BigcommerceOAuthAPI.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send(key)
      end
      conf
    end

    include Connection
    include Request
  end
end