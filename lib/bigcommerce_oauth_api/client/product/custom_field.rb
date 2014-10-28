module BigcommerceOAuthAPI
  class Client
    module CustomField
      def custom_fields(product_id, options = {})
        get("products/#{product_id}/custom_fields", options)
      end

      def custom_field(product_id, id, options = {})
        get("products/#{product_id}/custom_fields/#{id}", options)
      end

      def create_custom_field(product_id, options = {})
        post("products/#{product_id}/custom_fields", options)
      end

      def update_custom_field(product_id, id, options = {})
        put("products/#{product_id}/custom_fields/#{id}", options)
      end

      def delete_custom_field(product_id, id, options = {})
        delete("products/#{product_id}/custom_fields/#{id}", options)
      end
    end
  end
end