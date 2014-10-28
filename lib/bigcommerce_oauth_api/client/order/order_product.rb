module BigcommerceOAuthAPI
  class Client
    module OrderProduct
      def order_products(order_id, options = {})
        get("orders/#{order_id}/products", options)
      end

      def order_product(order_id, id, options = {})
        get("orders/#{order_id}/products/#{id}", options)
      end
    end
  end
end