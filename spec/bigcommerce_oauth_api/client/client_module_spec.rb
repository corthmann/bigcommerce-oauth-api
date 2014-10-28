require 'spec_helper'
require 'active_support/inflector'
require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/client'

describe BigcommerceOAuthAPI::Client do
  ['product', 'order']. each do |api_module|
    api_module_pluralized = api_module.pluralize

    before do
      @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                                :client_id => 'SECRET_ID',
                                                :oauth_token => 'SECRET_TOKEN')
    end

    describe ".#{api_module_pluralized}" do
      it "should get a list of #{api_module_pluralized}" do
        stub_get(@client, api_module_pluralized).
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.send(api_module_pluralized.to_sym)
        expect(a_get(@client, api_module_pluralized).
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe ".#{api_module}" do
      it "gets the #{api_module} with the given id" do
        id = 10
        stub_get(@client, "#{api_module_pluralized}/#{id}").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.send(api_module.to_sym, id)
        expect(a_get(@client, "#{api_module_pluralized}/#{id}").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe ".create_#{api_module}" do
      it "creates a #{api_module} with the given attributes" do
        options = { name: 'A', description: 'B'}
        stub_post(@client, api_module_pluralized).
            to_return(:body => options, :headers => { :content_type => "application/#{@client.format}" })
        @client.send("create_#{api_module}".to_sym, options)
        expect(a_post(@client, api_module_pluralized).
                   with(:body => options,
                        :headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe ".update_#{api_module}" do
      it "update the attributes of the #{api_module} with the given id" do
        id = 10
        options = { name: 'A', description: 'B'}
        stub_put(@client, "#{api_module_pluralized}/#{id}").
            with(:body => options).
            to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
        @client.send("update_#{api_module}".to_sym, id, options)
        expect(a_put(@client, "#{api_module_pluralized}/#{id}").
                   with(:body => options,
                        :headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe ".delete_#{api_module}" do
      it "deletes the #{api_module} with the given id" do
        id = 10
        stub_delete(@client, "#{api_module_pluralized}/#{id}").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.send("delete_#{api_module}".to_sym, id)
        expect(a_delete(@client, "#{api_module_pluralized}/#{id}").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe ".#{api_module_pluralized}_count" do
      it "returns the number of #{api_module_pluralized}" do
        stub_get(@client, "#{api_module_pluralized}/count").
            to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
        @client.send("#{api_module_pluralized}_count".to_sym)
        expect(a_get(@client, "#{api_module_pluralized}/count").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end
  end
end