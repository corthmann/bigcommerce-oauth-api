require 'active_support/inflector'

module BigcommerceOAuthAPI
  class Base
    protected

    def self.with_api_methods(map)
      map.each do |api, method_description|
        api_module = method_description[:api_module]
        api_scope = method_description[:scope]
        api_methods = method_description[:methods]
        if api_methods.include?(:all)
          with_all_action(api_module, api_scope)
        end

        if api_methods.include?(:select)
          with_select_action(api_module, api_scope)
        end

        if api_methods.include?(:create)
          with_create_action(api_module, api_scope)
        end

        if api_methods.include?(:update)
          with_update_action(api_module, api_scope)
        end

        if api_methods.include?(:delete)
          with_delete_action(api_module, api_scope)
        end

        if api_methods.include?(:count)
          with_count_action(api_module, api_scope)
        end
      end
    end

    def self.with_all_action(api_module, api_scope)
      if api_scope == :self
        class_eval %Q{
          def #{api_module.to_s.pluralize}(options = {})
            get('#{api_module.to_s.pluralize}', options)
          end
        }
      else
        class_eval %Q{
          def #{api_scope}_#{api_module.to_s.pluralize}(#{api_scope}_id, options = {})
            get("#{api_scope.to_s.pluralize}/\#{#{api_scope}_id}/#{api_module.to_s.pluralize}", options)
          end
        }
      end
    end

    def self.with_select_action(api_module, api_scope)
      if api_scope == :self
        class_eval %Q{
          def #{api_module}(id, options = {})
            get("#{api_module.to_s.pluralize}/\#{id}", options)
          end
        }
      else
        class_eval %Q{
          def #{api_scope}_#{api_module}(#{api_scope}_id, id, options = {})
            get("#{api_scope.to_s.pluralize}/\#{#{api_scope}_id}/#{api_module.to_s.pluralize}/\#{id}", options)
          end
        }
      end
    end

    def self.with_create_action(api_module, api_scope)
      if api_scope == :self
        class_eval %Q{
          def create_#{api_module}( options = {})
            post("#{api_module.to_s.pluralize}", options)
          end
        }
      else
        class_eval %Q{
          def create_#{api_scope}_#{api_module}(#{api_scope}_id, options = {})
            post("#{api_scope.to_s.pluralize}/\#{#{api_scope}_id}/#{api_module.to_s.pluralize}", options)
          end
        }
      end
    end

    def self.with_update_action(api_module, api_scope)
      if api_scope == :self
        class_eval %Q{
          def update_#{api_module}(id, options = {})
            put("#{api_module.to_s.pluralize}/\#{id}", options)
          end
        }
      else
        class_eval %Q{
          def update_#{api_scope}_#{api_module}(#{api_scope}_id, id, options = {})
            put("#{api_scope.to_s.pluralize}/\#{#{api_scope}_id}/#{api_module.to_s.pluralize}/\#{id}", options)
          end
        }
      end
    end

    def self.with_delete_action(api_module, api_scope)
      if api_scope == :self
        class_eval %Q{
          def delete_#{api_module}(id, options = {})
            delete("#{api_module.to_s.pluralize}/\#{id}", options)
          end
        }
      else
        class_eval %Q{
          def delete_#{api_scope}_#{api_module}(#{api_scope}_id, id, options = {})
            delete("#{api_scope.to_s.pluralize}/\#{#{api_scope}_id}/#{api_module.to_s.pluralize}/\#{id}", options)
          end
        }
      end
    end


    def self.with_count_action(api_module, api_scope)
      if api_scope == :self
        class_eval %Q{
          def #{api_module.to_s.pluralize}_count(options = {})
            get('#{api_module.to_s.pluralize}/count', options)
          end
        }
      else
        class_eval %Q{
          def #{api_scope}_#{api_module.to_s.pluralize}_count(#{api_scope}_id, options = {})
            get("#{api_scope.to_s.pluralize}/\#{#{api_scope}_id}/#{api_module.to_s.pluralize}/count", options)
          end
        }
      end
    end
  end
end