require 'bigcommerce_oauth_api/error'

module BigcommerceOAuthAPI
  module UrlHandler

    def base
      BigcommerceOAuthAPI::BASE
    end

    def api(store_hash, resource_path)
      "#{base}/#{store_hash}/v2/#{resource_path}"
    end

  end
end