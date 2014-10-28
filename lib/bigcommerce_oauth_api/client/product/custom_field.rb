module BigcommerceOAuthAPI
  class Client
    module CustomField
      def custom_fields(product_id, options = {})
        response = get("products/#{product_id}/custom_fields", options)
        response
      end

      def custom_field(product_id, id, options = {})
        response = get("products/#{product_id}/custom_fields/#{id}", options)
        response
      end

      def create_custom_field(product_id, options = {})
        response = post("products/#{product_id}/custom_fields", options)
        response
      end

      def update_custom_field(product_id, id, options = {})
        response = put("products/#{product_id}/custom_fields/#{id}", options)
        response
      end

      def delete_custom_field(product_id, id, options = {})
        response = delete("products/#{product_id}/custom_fields/#{id}", options)
        response
      end
    end
  end
end