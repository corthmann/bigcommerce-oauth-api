module BigcommerceOAuthAPI
  class Client
    module OrderMessage
      def order_messages(order_id, options = {})
        get("orders/#{order_id}/messages", options)
      end

      def order_message(order_id, id, options = {})
        get("orders/#{order_id}/messages/#{id}", options)
      end
    end
  end
end