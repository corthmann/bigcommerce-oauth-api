require 'faraday'

module FaradayMiddleware
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise BigcommerceOAuthAPI::BadRequest, response[:body]
        when 404
          raise BigcommerceOAuthAPI::NotFound, response[:body]
        when 429
          raise BigcommerceOAuthAPI::TooManyRequests, response[:response_headers]['X-Retry-After']
        when 500
          raise BigcommerceOAuthAPI::InternalServerError, response[:body]
        when 502
          raise BigcommerceOAuthAPI::BadGateway, response[:body]
        end
      end
    end

    def initialize(app)
      super app
    end
  end
end