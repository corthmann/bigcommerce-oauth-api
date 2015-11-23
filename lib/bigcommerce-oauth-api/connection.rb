require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }

module BigcommerceOAuthAPI
  module Connection
    private

    def connection
      options = {
        :headers => {
          'Accept' => "application/#{format}; charset=utf-8"
        }
      }

      if !if_modified_since.nil?
        options[:headers]['If-Modified-Since'] = if_modified_since.to_s
      end

      if is_legacy?
        options[:url] = "#{endpoint}/api/v2/"
      else
        options[:headers]['X-Auth-Client'] = client_id
        options[:headers]['X-Auth-Token'] = access_token
        options[:url] = "#{endpoint}/#{store_hash}/v2/"
      end

      Faraday::Connection.new(options) do |connection|
        connection.request :json
        connection.use Faraday::Request::UrlEncoded
        connection.options.timeout =  10 # open/read timeout in seconds
        connection.options.open_timeout = 10 # connection open timeout in seconds

        if is_legacy?
          connection.use Faraday::Request::BasicAuthentication, user_name, api_key
        end

        case format.to_s.downcase
        when 'json' then connection.response :json, :content_type => /\bjson$/
        end
        connection.use FaradayMiddleware::RaiseHttpException
        connection.adapter(adapter)
      end
    end
  end
end