require 'active_support/core_ext/hash/indifferent_access'

module BigcommerceOAuthAPI
  class Resource
    def initialize(attributes)
      @attributes = HashWithIndifferentAccess.new(attributes)
    end

    def [](key)
      value = memoize(key.to_sym) # get memoized value if present
      value || @attributes[key.to_sym]
    end

    def []=(key, value)
      @attributes[key.to_sym] = value
      unmemoize(key.to_sym) # protect against memoized data
    end

    def ==(other)
      self.to_h == other.to_h
    end

    def eql?(other)
      self == other
    end

    def respond_to?(method_name, include_all = false)
      super(method_name, include_all) ? true : @attributes.include?(method_name.to_s.gsub(/(\?$)|(=$)/, '').to_sym)
    end

    def to_h
      @attributes.to_h
    end

    def method_missing(method_sym, *arguments)
      method_type = method_sym.to_s[-1] # last char
      if @attributes.include?(method_sym) || method_type == '='
        attribute_name = method_sym.to_s.gsub(/(\?$)|(=$)/, '')
        case method_type
          when '='
            self.instance_eval build_attribute_setter(attribute_name)
          else
            self.instance_eval build_attribute_getter(attribute_name)
        end
        send(method_sym, *arguments)
      else
        super(method_sym, *arguments)
      end
    end

    def marshal_dump
      {}.merge(@attributes.to_h)
    end

    def marshal_load(attributes)
      send :initialize, attributes
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

    def unmemoize(name)
      var = instance_variable_get("@#{name.to_s}") rescue nil
      unless var.nil?
        instance_variable_set("@#{name.to_s}", nil)
      end
    end

    def build_attribute_getter(attribute_name)
      "def #{attribute_name}
        if @attributes[:#{attribute_name}] && @attributes[:#{attribute_name}].is_a?(Hash)
          memoize(:#{attribute_name}) do
            self.class.new(@attributes[:#{attribute_name}])
          end
        elsif @attributes[:#{attribute_name}] && @attributes[:#{attribute_name}].is_a?(Array)
          memoize(:#{attribute_name}) do
            @attributes[:#{attribute_name}].map do |entry|
              self.class.new(entry)
            end
          end
        else
          @attributes[:#{attribute_name}]
        end
      end"
    end

    def build_attribute_setter(attribute_name)
      "def #{attribute_name}=(value)
        @attributes[:#{attribute_name}] = value
        unmemoize(:#{attribute_name}) # protect against memoized data
      end"
    end
  end
end
