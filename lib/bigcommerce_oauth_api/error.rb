module BigcommerceOAuthAPI
  class Error < StandardError
    def inspect
      "#<BigcommerceOAuthAPI::Error: BigcommerceOAuthAPI::Error message=\"#{message}\">"
    end
  end

  # 400 HTTP
  class BadRequest < Error; end

  # 404 HTTP
  class NotFound < Error; end

  # 429 HTTP
  class TooManyRequests < Error; end

  # 500 HTTP
  class InternalServerError < Error; end

  # 502 HTTP
  class BadGateway < Error; end
end