module BigcommerceOAuthAPI
  class Error < StandardError
    def inspect
      "#<BigcommerceOAuthAPI::Error: BigcommerceOAuthAPI::Error message=\"#{message}\">"
    end
  end

  # 400 HTTP
  class BadRequest < Error; end

  # 401 HTTP
  class Unauthorized < Error; end

  # 403 HTTP
  class Forbidden < Error; end

  # 404 HTTP
  class NotFound < Error; end

  # 405 HTTP
  class MethodNotAllowed < Error; end

  # 406 HTTP
  class NotAcceptable < Error; end

  # 409 HTTP
  class Conflict  < Error; end

  # 413 HTTP
  class RequestEntityTooLarge < Error; end

  # 415 HTTP
  class UnsupportedMediaType < Error; end

  # 429 HTTP
  class TooManyRequests < Error; end

  # 500 HTTP
  class InternalServerError < Error; end

  # 501 HTTP
  class NotImplemented < Error; end

  # 502 HTTP
  class BadGateway < Error; end

  # 503 HTTP
  class ServiceUnavailable < Error; end

  # 507 HTTP
  class InsufficientStorage < Error; end

  # 509 HTTP (deprecated)
  # Returned to apps using Basic Authentication that have exceeded their rate limits.
  class BandwidthLimitExceeded < Error; end

  # Raised if the client attempts to define an api method that already is defined elsewhere.
  # Specs will catch this type of error since it will be thrown upon initialization.
  class MethodAlreadyDefinedError < Error; end

  # Raised if the client attempts to use a non-legacy api with a legacy configuration.
  class NonLegacyApi < Error; end
end

