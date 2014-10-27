require 'faraday'

module BigcommerceOAuthAPI
  module Configuration

    VALID_OPTIONS_KEYS = [
        :store_hash,
        :endpoint,
        :adapter,
        :client_id,
        :oauth_token,
        :format
    ].freeze

    DEFAULT_STORE_HASH = nil
    DEFAULT_ENDPOINT = 'https://api.bigcommerce.com/stores'.freeze
    DEFAULT_CLIENT_ID = nil
    DEFAULT_OAUTH_TOKEN = nil
    DEFAULT_FORMAT = :json
    DEFAULT_ADAPTER = Faraday.default_adapter

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.store_hash = DEFAULT_STORE_HASH
      self.endpoint = DEFAULT_ENDPOINT
      self.format = DEFAULT_FORMAT
      self.client_id = DEFAULT_CLIENT_ID
      self.oauth_token = DEFAULT_OAUTH_TOKEN
      self.adapter = DEFAULT_ADAPTER
    end

    def configure
      yield self
    end

    # Return the configuration values set in this module
    def options
      Hash[ * VALID_OPTIONS_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end