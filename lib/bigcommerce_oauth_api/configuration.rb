module BigcommerceOAuthAPI
  module Configuration
    VALID_CONNECTION_KEYS = [
        :endpoint
    ].freeze

    VALID_OPTIONS_KEYS = [
        :client_id,
        :oauth_token,
        :format
    ].freeze

    VALID_CONFIG_KEYS = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT = 'https://api.bigcommerce.com/stores'
    DEFAULT_CLIENT_ID = nil
    DEFAULT_OAUTH_TOKEN = nil
    DEFAULT_FORMAT = :json

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.format = DEFAULT_FORMAT
      self.client_id = DEFAULT_CLIENT_ID
      self.oauth_token = DEFAULT_OAUTH_TOKEN
    end

    def configure
      yield self
    end

    # Return the configuration values set in this module
    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end