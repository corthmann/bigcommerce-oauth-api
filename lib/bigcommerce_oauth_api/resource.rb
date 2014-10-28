require 'active_support/core_ext/hash/indifferent_access'

module BigcommerceOAuthAPI
  class Resource
    def initialize(attributes)
      @attributes = HashWithIndifferentAccess.new(attributes)
    end

    def [](key)
      @attributes[key.to_sym]
    end

    def []=(key, value)
      @attributes[key.to_sym] = value
    end

    def respond_to?(method_name)
      super(method_name) ? true : @attributes.include?(method_name.to_s.gsub(/(\?$)|(=$)/, '').to_sym)
    end

    def method_missing(method_sym, *arguments)
      method_name = method_sym.to_s
      attribute_name = method_name.gsub(/(\?$)|(=$)/, '')
      if @attributes.include?(method_name.to_sym)
        self.instance_eval build_attribute_getter(attribute_name)
        send(method_sym, *arguments)
      else
        super(method_sym, *arguments)
      end
    end

    def build_attribute_getter(attribute_name) #:nodoc:
      "def #{attribute_name}
        if @attributes[:#{attribute_name}] && @attributes[:#{attribute_name}].is_a?(Hash)
          @attributes[:#{attribute_name}].with_indifferent_access
        else
          @attributes[:#{attribute_name}]
        end
      end"
    end
  end
end