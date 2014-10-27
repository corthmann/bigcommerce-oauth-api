module BigcommerceOAuthAPI
  class Client
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options = {})
      merged_options = BigcommerceOAuthAPI.options.merge(options)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end
  end
end