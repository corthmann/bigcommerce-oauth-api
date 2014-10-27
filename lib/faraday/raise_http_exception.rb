require 'faraday'

module FaradayMiddleware
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise BigcommerceOAuthAPI::BadRequest, response[:message]
        when 404
          raise BigcommerceOAuthAPI::NotFound, response[:message]
        when 500
          raise BigcommerceOAuthAPI::InternalServerError, response[:message]
        when 502
          raise BigcommerceOAuthAPI::BadGateway, response[:message]
        end
      end
    end

    def initialize(app)
      super app
    end
  end
end