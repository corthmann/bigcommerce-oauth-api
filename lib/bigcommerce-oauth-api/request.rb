require 'bigcommerce-oauth-api/resource'

module BigcommerceOAuthAPI
  module Request

    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    def put(path, options = {})
      request(:put, path, options)
    end

    def delete(path, options = {})
      request(:delete, path, options)
    end

    private

    def request(method, path, options)
      response = connection.send(method) do |request|
        case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = options if !options.empty?
        end
      end

      if typecast_to_resource
        if response.status == 204 || response.status == 304
          nil
        elsif response.body.is_a?(Array)
          response.body.map! { |resource| Resource.new(resource) }
        else
          Resource.new(response.body)
        end
      else
        response.body
      end
    end
  end
end
