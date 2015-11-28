require 'active_support/inflector'
require 'bigcommerce-oauth-api/error'

module BigcommerceOAuthAPI
  class Base

    protected

    def self.with_api_methods(map)
      map.each do |_, method_description|
        api_module = method_description[:api_module]
        api_scope = method_description[:scope]
        is_legacy = (method_description[:legacy].nil? ? true : method_description[:legacy])
        path_prefix = (method_description.has_key?(:prefix_paths) ? "#{method_description[:prefix_paths]}/" : nil)
        method_prefix = (method_description.has_key?(:prefix_methods) ? "#{method_description[:prefix_methods]}_" : nil)
        method_description[:methods].each do |method|
          with_action(method, api_module, api_scope, path_prefix, method_prefix, is_legacy)
        end
      end
    end

    def self.with_action(method, api_module, api_scope, path_prefix = nil, method_prefix = nil, is_legacy = true)
      is_nested = api_scope != :self
      method_name, method_params, has_options = get_method_name_and_params(method, api_module, api_scope, is_nested, method_prefix)
      method_path = get_method_path(method, api_module, api_scope, is_nested)
      request_method = get_request_method(method)

      # Ensure that existing methods never are overwritten
      # Raise an error if it is attempted
      if self.method_defined?(:"#{method_name}")
        raise MethodAlreadyDefinedError.new("Method already defined: '#{method_name}'")
      end

      class_eval %Q{
        def #{method_name}#{method_params}
          #{(is_legacy ? '' : 'raise NonLegacyApi.new if is_legacy?')}
          #{request_method}("#{path_prefix}#{method_path}"#{( has_options ? ', options' : '')})
        end
      }
    end

    def self.get_method_name_and_params(method, api_module, api_scope, is_nested = false, method_prefix = nil)
      base = (is_nested ? "#{method_prefix}#{api_scope}_#{api_module}": "#{method_prefix}#{api_module}").to_s
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
