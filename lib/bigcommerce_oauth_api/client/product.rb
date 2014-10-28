module BigcommerceOAuthAPI
  class Client
    module Product
      Dir[File.expand_path('../product/*.rb', __FILE__)].each { |f| require f }

      def products(options = {})
        get('products', options)
      end

      def product(id, options = {})
        get("products/#{id}", options)
      end

      def create_product(options = {})
        post("products", options)
      end

      def update_product(id, options = {})
        put("products/#{id}", options)
      end

      def delete_product(id, options = {})
        delete("products/#{id}", options)
      end

      def products_count(options = {})
        get('products/count', options)
      end

      include CustomField
    end
  end
end