require 'spec_helper'
require 'active_support/inflector'
require 'bigcommerce-oauth-api'
require 'bigcommerce-oauth-api/client'

describe BigcommerceOAuthAPI::Client do
  [
      { api_module: 'post', methods: [:all, :select, :create, :update, :delete], prefix_paths: 'blog', prefix_methods: 'blog'},
      { api_module: 'tag', methods: [:all], prefix_paths: 'blog', prefix_methods: 'blog'},
      { api_module: 'brand', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'category', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'banner', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'gift_certificate', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'customer', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'customer_group', methods: [:all, :select, :create, :update, :delete]},
      { api_module: 'country', scope: :self, methods: [:all, :select, :count]},
      { api_module: 'order_status', methods: [:all, :select]},
      { api_module: 'order', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'method', methods: [:all], prefix_paths: 'payments', prefix_methods: 'payment'},
      { api_module: 'option', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'option_set', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'product', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'coupon', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'redirect', methods: [:all, :select, :create, :update, :delete, :count]},
      { api_module: 'zone', methods: [:all, :select, :create, :update, :delete], prefix_paths: 'shipping', prefix_methods: 'shipping'},
      { api_module: 'tax_class', scope: :self, methods: [:all, :select]},
      { api_module: 'hook', methods: [:all, :select, :create, :update, :delete], legacy: false}
  ]. each do |api_description|
    api_module = api_description[:api_module]
    api_module_pluralized = api_module.pluralize
    path_prefix = (api_description.has_key?(:prefix_paths) ? "#{api_description[:prefix_paths]}/" : nil)
    method_prefix = (api_description.has_key?(:prefix_methods) ? "#{api_description[:prefix_methods]}_" : nil)
    has_legacy_support = (api_description.has_key?(:legacy) ? api_description[:legacy] : true)

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

        if api_description[:methods].include?(:all)
          describe ".#{method_prefix}#{api_module_pluralized}" do
            if config_type == :legacy && !has_legacy_support
              it 'should raise a non legacy api error' do
                expect { @client.send("#{method_prefix}#{api_module_pluralized}".to_sym) }.
                    to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
              end
            else
              it "should get a list of #{api_module_pluralized}" do
                stub_get(@client, "#{path_prefix}#{api_module_pluralized}").
                    to_return(:headers => { :content_type => "application/#{@client.format}" })
                @client.send("#{method_prefix}#{api_module_pluralized}".to_sym)
                if config_type == :legacy
                  expect(a_get(@client, "#{path_prefix}#{api_module_pluralized}")).to have_been_made
                else
                  expect(a_get(@client, "#{path_prefix}#{api_module_pluralized}").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end

            end
          end
        end

        if api_description[:methods].include?(:select)
          describe ".#{method_prefix}#{api_module}" do
            if config_type == :legacy && !has_legacy_support
              it 'should raise a non legacy api error' do
                id = 10
                expect { @client.send("#{method_prefix}#{api_module}".to_sym, id) }.
                    to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
              end
            else
              it "gets the #{api_module} with the given id" do
                id = 10
                stub_get(@client, "#{path_prefix}#{api_module_pluralized}/#{id}").
                    to_return(:headers => { :content_type => "application/#{@client.format}" })
                @client.send("#{method_prefix}#{api_module}".to_sym, id)
                if config_type == :legacy
                  expect(a_get(@client, "#{path_prefix}#{api_module_pluralized}/#{id}")).to have_been_made
                else
                  expect(a_get(@client, "#{path_prefix}#{api_module_pluralized}/#{id}").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            end
          end
        end

        if api_description[:methods].include?(:create)
          describe ".create_#{method_prefix}#{api_module}" do
            if config_type == :legacy && !has_legacy_support
              it 'should raise a non legacy api error' do
                options = { name: 'A', description: 'B'}
                expect { @client.send("create_#{method_prefix}#{api_module}".to_sym, options) }.
                    to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
              end
            else
              it "creates a #{api_module} with the given attributes" do
                options = { name: 'A', description: 'B'}
                stub_post(@client, "#{path_prefix}#{api_module_pluralized}").
                    to_return(:body => options.to_json, :headers => { :content_type => "application/#{@client.format}" })

                @client.send("create_#{method_prefix}#{api_module}".to_sym, options)
                if config_type == :legacy
                  expect(a_post(@client, "#{path_prefix}#{api_module_pluralized}")).to have_been_made
                else
                  expect(a_post(@client, "#{path_prefix}#{api_module_pluralized}").
                             with(:body => options,
                                  :headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            end
          end
        end

        if api_description[:methods].include?(:update)
          describe ".update_#{method_prefix}#{api_module}" do
            if config_type == :legacy && !has_legacy_support
              it 'should raise a non legacy api error' do
                id = 10
                options = { name: 'A', description: 'B'}
                expect { @client.send("update_#{method_prefix}#{api_module}".to_sym, id, options) }.
                    to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
              end
            else
              it "update the attributes of the #{api_module} with the given id" do
                id = 10
                options = { name: 'A', description: 'B'}
                stub_put(@client, "#{path_prefix}#{api_module_pluralized}/#{id}").
                    with(:body => options).
                    to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })

                @client.send("update_#{method_prefix}#{api_module}".to_sym, id, options)
                if config_type == :legacy
                  expect(a_put(@client, "#{path_prefix}#{api_module_pluralized}/#{id}")).
                             to have_been_made
                else
                  expect(a_put(@client, "#{path_prefix}#{api_module_pluralized}/#{id}").
                             with(:body => options,
                                  :headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            end
          end
        end

        if api_description[:methods].include?(:delete)
          describe ".delete_#{method_prefix}#{api_module}" do
            if config_type == :legacy && !has_legacy_support
              it 'should raise a non legacy api error' do
                id = 10
                expect { @client.send("delete_#{method_prefix}#{api_module}".to_sym, id) }.
                    to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
              end
            else
              it "deletes the #{api_module} with the given id" do
                id = 10
                stub_delete(@client, "#{path_prefix}#{api_module_pluralized}/#{id}").
                    to_return(:headers => { :content_type => "application/#{@client.format}" })
                @client.send("delete_#{method_prefix}#{api_module}".to_sym, id)
                if config_type == :legacy
                  expect(a_delete(@client, "#{path_prefix}#{api_module_pluralized}/#{id}")).to have_been_made
                else
                  expect(a_delete(@client, "#{path_prefix}#{api_module_pluralized}/#{id}").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            end
          end
        end

        if api_description[:methods].include?(:count)
          describe ".#{method_prefix}#{api_module_pluralized}_count" do
            if config_type == :legacy && !has_legacy_support
              it 'should raise a non legacy api error' do
                expect { @client.send("#{method_prefix}#{api_module_pluralized}_count".to_sym) }.
                    to raise_error(BigcommerceOAuthAPI::NonLegacyApi)
              end
            else
              it "returns the number of #{api_module_pluralized}" do
                stub_get(@client, "#{path_prefix}#{api_module_pluralized}/count").
                    to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
                @client.send("#{method_prefix}#{api_module_pluralized}_count".to_sym)
                if config_type == :legacy
                  expect(a_get(@client, "#{path_prefix}#{api_module_pluralized}/count")).to have_been_made
                else
                  expect(a_get(@client, "#{path_prefix}#{api_module_pluralized}/count").
                             with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
                end
              end
            end
          end
        end
      end
    end
  end
end
