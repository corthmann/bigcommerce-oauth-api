require 'faraday'

module FaradayMiddleware
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise BigcommerceOAuthAPI::BadRequest.new(response[:message])
        when 404
          raise BigcommerceOAuthAPI::NotFound.new(response[:message])
        when 500
          raise BigcommerceOAuthAPI::InternalServerError.new(response[:message])
        when 502
          raise BigcommerceOAuthAPI::BadGateway.new(response[:message])
        end
      end
    end

    def initialize(app)
      super app
    end
  end
end