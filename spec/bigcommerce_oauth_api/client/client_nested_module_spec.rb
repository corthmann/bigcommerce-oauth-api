require 'spec_helper'
require 'active_support/inflector'
require 'bigcommerce-oauth-api'
require 'bigcommerce-oauth-api/client'

describe BigcommerceOAuthAPI::Client do
  [
      { api_module: 'product', api_parent_module: 'order', methods: [:all, :select]},
      { api_module: 'shipping_address', api_parent_module: 'order', methods: [:all, :select]},
      { api_module: 'message', api_parent_module: 'order', methods: [:all, :select]},
      { api_module: 'shipment', api_parent_module: 'order', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'configurable_field', api_parent_module: 'product', methods: [:all, :select, :delete]},
      { api_module: 'custom_field', api_parent_module: 'product', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'option', api_parent_module: 'option_set', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'value', api_parent_module: 'option_set', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'discount_rule', api_parent_module: 'product', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'image', api_parent_module: 'product', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'option', api_parent_module: 'product', methods: [:all, :select]},
      { api_module: 'review', api_parent_module: 'product', methods: [:all]},
      { api_module: 'rule', api_parent_module: 'product', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'video', api_parent_module: 'product', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'sku', api_parent_module: 'product', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'state', api_parent_module: 'country', methods: [:all, :select, :count]},
      { api_module: 'address', api_parent_module: 'customer', methods: [:all, :select, :create, :update, :delete]}
  ]. each do |nested_module|
    api_parent_module = nested_module[:api_parent_module]
    api_parent_module_pluralized = nested_module[:api_parent_module].pluralize
    api_module = nested_module[:api_module]
    api_module_pluralized = api_module.pluralize
    path_prefix = (nested_module.has_key?(:prefix_paths) ? "#{nested_module[:prefix_paths]}/" : nil)
    method_prefix = (nested_module.has_key?(:prefix_methods) ? "#{nested_module[:prefix_methods]}_" : nil)
    has_legacy_support = (nested_module.has_key?(:legacy) ? nested_module[:legacy] : true)

    [:legacy, :oauth].each do |config_type|
      context "given a #{config_type} configuration" do
        before do
          @client = case config_type
                      when :legacy
                        BigcommerceOAuthAPI::Client.new(:endpoint => 'http://example.bigcommerce.com',
                                                        :user_name => 'USER',
                                                        :api_key => 'API_KEY')
                      when :oauth
                        BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                                        :client_id => 'SECRET_ID',
                                                        :access_token => 'SECRET_TOKEN')
                    end
        end

        if nested_module[:methods].include?(:all)
          describe ".#{method_prefix}#{api_parent_module}_#{api_module_pluralized}" do
            # NOTICE! Currently all the nested APIs have legacy support
            # if config_type == :legacy && !has_legacy_support
            #   it 'should raise a non legacy api error' do
            #     parent_id = 10
            #     expect { @client.send("#{method_prefix}#{api_parent_module}_#{api_module_pluralized}".to_sym, parent_id) }.
            #         to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
            #   end
            # else
              it "should get a list of #{api_module_pluralized} for the given #{api_parent_module}" do
                parent_id = 10
                stub_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
                    to_return(:headers => { :content_type => "application/#{@client.format}" })
                @client.send("#{method_prefix}#{api_parent_module}_#{api_module_pluralized}".to_sym, parent_id)
                if config_type == :legacy
                  expect(a_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}"))
                      .to have_been_made
                else
                  expect(a_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            # end
          end
        end

        if nested_module[:methods].include?(:select)
          describe ".#{method_prefix}#{api_parent_module}_#{api_module}" do
            # NOTICE! Currently all the nested APIs have legacy support
            # if config_type == :legacy && !has_legacy_support
            #   it 'should raise a non legacy api error' do
            #     id = 10
            #     parent_id = 5
            #     expect { @client.send("#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, id) }.
            #         to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
            #   end
            # else
              it "gets the #{api_module} with the given id for the given #{api_parent_module}" do
                id = 10
                parent_id = 5
                stub_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                    to_return(:headers => { :content_type => "application/#{@client.format}" })
                @client.send("#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, id)
                if config_type == :legacy
                  expect(a_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}"))
                      .to have_been_made
                else
                  expect(a_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            # end
          end
        end

        if nested_module[:methods].include?(:create)
          describe ".create_#{method_prefix}#{api_parent_module}_#{api_module}" do
            # NOTICE! Currently all the nested APIs have legacy support
            # if config_type == :legacy && !has_legacy_support
            #   it 'should raise a non legacy api error' do
            #     options = { name: 'A', description: 'B'}
            #     parent_id = 5
            #     expect { @client.send("create_#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, options) }.
            #         to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
            #   end
            # else
              it "creates a #{api_module} with the given attributes for the given #{api_parent_module}" do
                options = { name: 'A', description: 'B'}
                parent_id = 5
                stub_post(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
                    to_return(:body => options.to_json, :headers => { :content_type => "application/#{@client.format}" })
                @client.send("create_#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, options)
                if config_type == :legacy
                  expect(a_post(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}"))
                      .to have_been_made
                else
                  expect(a_post(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
                             with(:body => options,
                                  :headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            # end
          end
        end

        if nested_module[:methods].include?(:update)
          describe ".update_#{method_prefix}#{api_parent_module}_#{api_module}" do
            # NOTICE! Currently all the nested APIs have legacy support
            # if config_type == :legacy && !has_legacy_support
            #   it 'should raise a non legacy api error' do
            #     options = { name: 'A', description: 'B'}
            #     id = 10
            #     parent_id = 5
            #     expect { @client.send("update_#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, id, options) }.
            #         to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
            #   end
            # else
              it "update the attributes of the #{api_module} with the given id for the #{api_parent_module}" do
                id = 10
                parent_id = 5
                options = { name: 'A', description: 'B'}
                stub_put(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                    with(:body => options).
                    to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
                @client.send("update_#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, id, options)
                if config_type == :legacy
                  expect(a_put(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}"))
                      .to have_been_made
                else
                  expect(a_put(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                             with(:body => options,
                                  :headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            # end
          end
        end

        if nested_module[:methods].include?(:delete)
          describe ".delete_#{method_prefix}#{api_parent_module}_#{api_module}" do
            # NOTICE! Currently all the nested APIs have legacy support
            # if config_type == :legacy && !has_legacy_support
            #   it 'should raise a non legacy api error' do
            #     id = 10
            #     parent_id = 5
            #     expect { @client.send("delete_#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, id) }.
            #         to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
            #   end
            # else
              it "deletes the #{api_module} with the given id for the #{api_parent_module}" do
                id = 10
                parent_id = 5
                stub_delete(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                    to_return(:headers => { :content_type => "application/#{@client.format}" })
                @client.send("delete_#{method_prefix}#{api_parent_module}_#{api_module}".to_sym, parent_id, id)
                if config_type == :legacy
                  expect(a_delete(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}"))
                      .to have_been_made
                else
                  expect(a_delete(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            # end
          end
        end

        if nested_module[:methods].include?(:count)
          describe ".#{method_prefix}#{api_parent_module}_#{api_module_pluralized}_count" do
            # NOTICE! Currently all the nested APIs have legacy support
            # if config_type == :legacy && !has_legacy_support
            #   it 'should raise a non legacy api error' do
            #     parent_id = 5
            #     expect { @client.send("#{method_prefix}#{api_parent_module}_#{api_module_pluralized}_count".to_sym, parent_id) }.
            #         to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
            #   end
            # else
              it "returns the number of #{api_module_pluralized} for the #{api_parent_module}" do
                parent_id = 5
                stub_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/count").
                    to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
                @client.send("#{method_prefix}#{api_parent_module}_#{api_module_pluralized}_count".to_sym, parent_id)
                if config_type == :legacy
                  expect(a_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/count"))
                      .to have_been_made
                else
                  expect(a_get(@client, "#{path_prefix}#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/count").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            # end
          end
        end
      end
    end
  end
end