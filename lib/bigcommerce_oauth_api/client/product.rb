module BigcommerceOAuthAPI
  class Client
    module Product
      def products(options = {})
        response = get('products', options)
        response
      end
    end
  end
end