require 'bigcommerce-oauth-api/connection'
require 'bigcommerce-oauth-api/request'
require 'bigcommerce-oauth-api/base'

module BigcommerceOAuthAPI
  class API < Base
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

    def is_legacy?
      !user_name.nil? && !api_key.nil? && endpoint != Configuration::DEFAULT_ENDPOINT
    end

    include Connection
    include Request
  end
end
