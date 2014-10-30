require 'active_support/inflector'

module BigcommerceOAuthAPI
  class Base
    protected

    def self.with_api_methods(map)
      map.each do |api, method_description|
        api_module = method_description[:api_module]
        api_scope = method_description[:scope]
        method_description[:methods].each do |method|
          with_action(method, api_module, api_scope)
        end
      end
    end

    def self.with_action(method, api_module, api_scope)
      is_nested = api_scope != :self
      method_name, method_params, has_options = get_method_name_and_params(method, api_module, api_scope, is_nested)
      method_path = get_method_path(method, api_module, api_scope, is_nested)
      request_method = get_request_method(method)

      class_eval %Q{
        def #{method_name}#{method_params}
          #{request_method}("#{method_path}"#{( has_options ? ', options' : '')})
        end
      }
    end

    def self.get_method_name_and_params(method, api_module, api_scope, is_nested = false)
      base = (is_nested ? "#{api_scope}_#{api_module}": api_module).to_s
      params_base = "(#{(is_nested ? "#{api_scope}_id, ": '')}"
      has_options = method != :delete
      case method
        when :all
          return base.pluralize, "#{params_base}options = {})", has_options
        when :count
          return "#{base.pluralize}_count", "#{params_base}options = {})", has_options
        when :select
          return base, "#{params_base}id, options = {})", has_options
        when :create
          return "#{method}_#{base}", "#{params_base}options = {})", has_options
        when :update
          return "#{method}_#{base}", "#{params_base}id, options = {})", has_options
        when :delete
          return "#{method}_#{base}", "#{params_base}id)", has_options
      end
    end

    def self.get_method_path(method, api_module, api_scope, is_nested = false)
      base = (is_nested ? "#{api_scope.to_s.pluralize}/\#{#{api_scope}_id}/#{api_module}": api_module).to_s.pluralize
      case method
        when :all, :create
          return base
        when :count
          return "#{base}/count"
        when :select, :update, :delete
          return "#{base}/\#{id}"
      end
    end

    def self.get_request_method(method)
      case method
        when :all, :count, :select
          return :get
        when :create
          return :post
        when :update
          return :put
        when :delete
          return :delete
      end
    end
  end
end