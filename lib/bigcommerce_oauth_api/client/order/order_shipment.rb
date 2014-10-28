module BigcommerceOAuthAPI
  class Client
    module OrderShipment
      def order_shipments(order_id, options = {})
        get("orders/#{order_id}/shipments", options)
      end

      def order_shipment(order_id, id, options = {})
        get("orders/#{order_id}/shipments/#{id}", options)
      end

      def create_shipment(order_id, options = {})
        post("orders/#{order_id}/shipments", options)
      end

      def update_shipment(order_id, id, options = {})
        put("orders/#{order_id}/shipments/#{id}", options)
      end

      def delete_shipment(order_id, id, options = {})
        delete("orders/#{order_id}/shipments/#{id}", options)
      end
    end
  end
end