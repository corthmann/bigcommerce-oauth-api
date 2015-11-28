require 'faraday'

module BigcommerceOAuthAPI
  module Configuration

    VALID_OPTIONS_KEYS = [
        :store_hash,
        :endpoint,
        :client_id,
        :access_token,
        :format,
        :if_modified_since,
        # legacy authentication
        :user_name,
        :api_key,
        # connection / faraday
        :adapter,
        :timeout,
        :open_timeout,
        # library
        :typecast_to_resource
    ].freeze

    DEFAULT_STORE_HASH = nil
    DEFAULT_ENDPOINT = 'https://api.bigcommerce.com/stores'.freeze
    DEFAULT_CLIENT_ID = nil
    DEFAULT_ACCESS_TOKEN = nil
    DEFAULT_FORMAT = :json
    DEFAULT_ADAPTER = Faraday.default_adapter
    DEFAULT_IF_MODIFIED_SINCE = nil
    DEFAULT_TYPECAST_TO_RESOURCE = true # if set to false then response-objects with be of type Hash.
    DEFAULT_USER_NAME = nil
    DEFAULT_API_KEY = nil
    DEFAULT_TIMEOUT = 5
    DEFAULT_OPEN_TIMEOUT = 2

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.store_hash = DEFAULT_STORE_HASH
      self.endpoint = DEFAULT_ENDPOINT
      self.format = DEFAULT_FORMAT
      self.client_id = DEFAULT_CLIENT_ID
      self.access_token = DEFAULT_ACCESS_TOKEN
      self.adapter = DEFAULT_ADAPTER
      self.if_modified_since = DEFAULT_IF_MODIFIED_SINCE
      self.typecast_to_resource = DEFAULT_TYPECAST_TO_RESOURCE
      self.user_name = DEFAULT_USER_NAME
      self.api_key = DEFAULT_API_KEY
      self.timeout = DEFAULT_TIMEOUT
      self.open_timeout = DEFAULT_OPEN_TIMEOUT
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
