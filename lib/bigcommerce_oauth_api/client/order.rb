module BigcommerceOAuthAPI
  class Client
    module Order
      Dir[File.expand_path('../order/*.rb', __FILE__)].each { |f| require f }

      def orders(options = {})
        get('orders', options)
      end

      def order(id, options = {})
        get("orders/#{id}", options)
      end

      def create_order(options = {})
        post("orders", options)
      end

      def update_order(id, options = {})
        put("orders/#{id}", options)
      end

      def delete_order(id, options = {})
        delete("orders/#{id}", options)
      end

      def orders_count(options = {})
        get('orders/count', options)
      end

      include OrderProduct
      include OrderShippingAddress
    end
  end
end