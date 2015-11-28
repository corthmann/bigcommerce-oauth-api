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

    def ==(other)
      self.to_h == other.to_h
    end

    def eql?(other)
      self == other
    end

    def respond_to?(method_name)
      super(method_name) ? true : @attributes.include?(method_name.to_s.gsub(/(\?$)|(=$)/, '').to_sym)
    end

    def to_h
      @attributes.to_h
    end

    def method_missing(method_sym, *arguments)
      if @attributes.include?(method_sym)
        attribute_name = method_sym.to_s.gsub(/(\?$)|(=$)/, '')
        self.instance_eval build_attribute_getter(attribute_name)
        send(method_sym, *arguments)
      else
        super(method_sym, *arguments)
      end
    end

    def build_attribute_getter(attribute_name)
      "def #{attribute_name}
        if @attributes[:#{attribute_name}] && @attributes[:#{attribute_name}].is_a?(Hash)
          memoize(:#{attribute_name}) do
            self.class.new(@attributes[:#{attribute_name}])
          end
        else
          @attributes[:#{attribute_name}]
        end
      end"
    end

    private

    def memoize(name, &block)
      var = instance_variable_get("@#{name.to_s}") rescue nil
      if var.nil? && block_given?
        var = yield
        instance_variable_set("@#{name.to_s}", var)
      end

      var
    end
  end
end
