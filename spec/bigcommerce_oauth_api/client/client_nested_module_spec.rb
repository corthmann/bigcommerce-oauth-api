require 'spec_helper'
require 'active_support/inflector'
require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/client'

describe BigcommerceOAuthAPI::Client do
  [
      { api_module: 'product', api_parent_module: 'order', methods: [:all, :one]},
      { api_module: 'shipping_address', api_parent_module: 'order', methods: [:all, :one]},
      { api_module: 'message', api_parent_module: 'order', methods: [:all, :one]},
      { api_module: 'shipment', api_parent_module: 'order', methods: [:all, :one, :create, :update, :delete]},
      { api_module: 'custom_field', api_parent_module: 'product', methods: [:all, :one, :create, :update, :delete]}
  ]. each do |nested_module|
    api_parent_module = nested_module[:api_parent_module]
    api_parent_module_pluralized = nested_module[:api_parent_module].pluralize
    api_module = nested_module[:api_module]
    api_module_pluralized = api_module.pluralize

    before do
      @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                                :client_id => 'SECRET_ID',
                                                :oauth_token => 'SECRET_TOKEN')
    end

    if nested_module[:methods].include?(:all)
      describe ".#{api_parent_module}_#{api_module_pluralized}" do
        it "should get a list of #{api_module_pluralized} for the given #{api_parent_module}" do
          parent_id = 10
          stub_get(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
              to_return(:headers => { :content_type => "application/#{@client.format}" })
          @client.send("#{api_parent_module}_#{api_module_pluralized}".to_sym, parent_id)
          expect(a_get(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
                     with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                       'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
        end
      end
    end

    if nested_module[:methods].include?(:one)
      describe ".#{api_parent_module}_#{api_module}" do
        it "gets the #{api_module} with the given id for the given #{api_parent_module}" do
          id = 10
          parent_id = 5
          stub_get(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
              to_return(:headers => { :content_type => "application/#{@client.format}" })
          @client.send("#{api_parent_module}_#{api_module}".to_sym, parent_id, id)
          expect(a_get(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                     with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                       'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
        end
      end
    end

    if nested_module[:methods].include?(:create)
      describe ".create_#{api_parent_module}_#{api_module}" do
        it "creates a #{api_module} with the given attributes for the given #{api_parent_module}" do
          options = { name: 'A', description: 'B'}
          parent_id = 5
          stub_post(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
              to_return(:body => options, :headers => { :content_type => "application/#{@client.format}" })
          @client.send("create_#{api_parent_module}_#{api_module}".to_sym, parent_id, options)
          expect(a_post(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}").
                     with(:body => options,
                          :headers => {'X-Auth-Client' => 'SECRET_ID',
                                       'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
        end
      end
    end

    if nested_module[:methods].include?(:update)
      describe ".update_#{api_parent_module}_#{api_module}" do
        it "update the attributes of the #{api_module} with the given id for the #{api_parent_module}" do
          id = 10
          parent_id = 5
          options = { name: 'A', description: 'B'}
          stub_put(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
              with(:body => options).
              to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
          @client.send("update_#{api_parent_module}_#{api_module}".to_sym, parent_id, id, options)
          expect(a_put(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                     with(:body => options,
                          :headers => {'X-Auth-Client' => 'SECRET_ID',
                                       'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
        end
      end
    end

    if nested_module[:methods].include?(:delete)
      describe ".delete_#{api_parent_module}_#{api_module}" do
        it "deletes the #{api_module} with the given id for the #{api_parent_module}" do
          id = 10
          parent_id = 5
          stub_delete(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
              to_return(:headers => { :content_type => "application/#{@client.format}" })
          @client.send("delete_#{api_parent_module}_#{api_module}".to_sym, parent_id, id)
          expect(a_delete(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/#{id}").
                     with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                       'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
        end
      end
    end

    if nested_module[:methods].include?(:count)
      describe ".#{api_module_pluralized}_count" do
        it "returns the number of #{api_module_pluralized} for the #{api_parent_module}" do
          parent_id = 5
          stub_get(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/count").
              to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
          @client.send("#{api_module_pluralized}_count".to_sym)
          expect(a_get(@client, "#{api_parent_module_pluralized}/#{parent_id}/#{api_module_pluralized}/count").
                     with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                       'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
        end
      end
    end
  end
end