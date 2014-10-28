module BigcommerceOAuthAPI
  class Client
    module OrderShippingAddress
      def order_shipping_addresses(order_id, options = {})
        get("orders/#{order_id}/shipping_addresses", options)
      end

      def order_shipping_address(order_id, id, options = {})
        get("orders/#{order_id}/shipping_addresses/#{id}", options)
      end
    end
  end
end