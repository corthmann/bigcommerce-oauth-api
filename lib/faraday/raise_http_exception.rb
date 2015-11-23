require 'faraday'

module FaradayMiddleware
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
          when 400 then raise BigcommerceOAuthAPI::BadRequest,             response[:body]
          when 401 then raise BigcommerceOAuthAPI::Unauthorized,           response[:body]
          when 403 then raise BigcommerceOAuthAPI::Forbidden,              response[:body]
          when 404 then raise BigcommerceOAuthAPI::NotFound,               response[:body]
          when 405 then raise BigcommerceOAuthAPI::MethodNotAllowed,       response[:body]
          when 406 then raise BigcommerceOAuthAPI::NotAcceptable,          response[:body]
          when 409 then raise BigcommerceOAuthAPI::Conflict,               response[:body]
          when 413 then raise BigcommerceOAuthAPI::RequestEntityTooLarge,  response[:body]
          when 415 then raise BigcommerceOAuthAPI::UnsupportedMediaType,   response[:body]
          when 429 then raise BigcommerceOAuthAPI::TooManyRequests,        response[:response_headers]['X-Retry-After']
          when 500 then raise BigcommerceOAuthAPI::InternalServerError,    response[:body]
          when 501 then raise BigcommerceOAuthAPI::NotImplemented,         response[:body]
          when 502 then raise BigcommerceOAuthAPI::BadGateway,             response[:body]
          when 503 then raise BigcommerceOAuthAPI::ServiceUnavailable,     response[:body]
          when 507 then raise BigcommerceOAuthAPI::InsufficientStorage,    response[:body]
          when 509 then raise BigcommerceOAuthAPI::BandwidthLimitExceeded, response[:body]
        end
      end
    end

    def initialize(app)
      super app
    end
  end
end
