module BigcommerceOAuthAPI
  class Client
    module Product
      Dir[File.expand_path('../product/*.rb', __FILE__)].each { |f| require f }

      def products(options = {})
        response = get('products', options)
        response
      end

      def product(id, options = {})
        response = get("products/#{id}", options)
        response
      end

      def create_product(options = {})
        response = post("products", options)
        response
      end

      def update_product(id, options = {})
        response = put("products/#{id}", options)
        response
      end

      def delete_product(id, options = {})
        response = delete("products/#{id}", options)
        response
      end

      def products_count(options = {})
        response = get('products/count', options)
        response
      end

      include CustomField
    end
  end
end