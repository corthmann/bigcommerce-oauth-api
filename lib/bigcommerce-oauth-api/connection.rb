require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }

module BigcommerceOAuthAPI
  module Connection
    private

    def connection
      options = {
          :headers => {
              'Accept' => "application/#{format}; charset=utf-8",
              'X-Auth-Client' => client_id,
              'X-Auth-Token' => access_token
          },
          :url => "#{endpoint}/#{store_hash}/v2/"
      }

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        case format.to_s.downcase
        when 'json' then connection.use Faraday::Response::ParseJson
        end
        connection.use FaradayMiddleware::RaiseHttpException
        connection.adapter(adapter)
      end
    end
  end
end