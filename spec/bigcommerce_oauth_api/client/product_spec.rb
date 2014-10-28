require 'spec_helper'
require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/client'

describe BigcommerceOAuthAPI::Client do
  before do
    @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                              :client_id => 'SECRET_ID',
                                              :oauth_token => 'SECRET_TOKEN')
  end

  describe '.products' do
    it 'should get a list of products' do
      stub_get(@client, 'products').
          to_return(:headers => { :content_type => "application/#{@client.format}" })
      @client.products
      expect(a_get(@client, 'products').
                 with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                   'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
    end
  end

  describe '.product' do
    it 'gets the product with the given id' do
      id = 10
      stub_get(@client, "products/#{id}").
          to_return(:headers => { :content_type => "application/#{@client.format}" })
      @client.product(id)
      expect(a_get(@client, "products/#{id}").
                 with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                   'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
    end
  end

  describe '.create_product' do
    it 'creates a product with the given attributes' do
      product = { name: 'A', description: 'B'}
      stub_post(@client, 'products').
          to_return(:body => product, :headers => { :content_type => "application/#{@client.format}" })
      @client.create_product(product)
      expect(a_post(@client, 'products').
                 with(:body => product,
                      :headers => {'X-Auth-Client' => 'SECRET_ID',
                                   'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
    end
  end

  describe '.update_product' do
    it 'update the attributes of the product with the given id' do
      id = 10
      product = { name: 'A', description: 'B'}
      stub_put(@client, "products/#{id}").
          with(:body => product).
          to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
      @client.update_product(id, product)
      expect(a_put(@client, "products/#{id}").
                 with(:body => product,
                      :headers => {'X-Auth-Client' => 'SECRET_ID',
                                   'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
    end
  end

  describe '.delete_product' do
    it 'deletes the product with the given id' do
      id = 10
      stub_delete(@client, "products/#{id}").
          to_return(:headers => { :content_type => "application/#{@client.format}" })
      @client.delete_product(id)
      expect(a_delete(@client, "products/#{id}").
                 with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                   'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
    end
  end

  describe '.products_count' do
    it 'gets the product with the given id' do
      stub_get(@client, "products/count").
          to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
      @client.products_count
      expect(a_get(@client, "products/count").
                 with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                   'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
    end
  end

  describe 'product custom fields API' do
    describe '.custom_fields' do
      it 'should get a list of custom fields for the given product' do
        product_id = 10
        stub_get(@client, "products/#{product_id}/custom_fields").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.custom_fields(product_id)
        expect(a_get(@client, "products/#{product_id}/custom_fields").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.custom_field' do
      it 'gets the product custom field with the given id' do
        product_id = 10
        id = 2
        stub_get(@client, "products/#{product_id}/custom_fields/#{id}").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.custom_field(product_id, id)
        expect(a_get(@client, "products/#{product_id}/custom_fields/#{id}").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.create_custom_field' do
      it 'creates a custom field with the given attributes for the given product' do
        product_id = 10
        options = { name: 'A', description: 'B'}
        stub_post(@client, "products/#{product_id}/custom_fields").
            to_return(:body => options, :headers => { :content_type => "application/#{@client.format}" })
        @client.create_custom_field(product_id, options)
        expect(a_post(@client, "products/#{product_id}/custom_fields").
                   with(:body => options,
                        :headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.update_custom_field' do
      it 'update the attributes of the product with the given id' do
        product_id = 10
        id = 2
        options = { name: 'A', description: 'B'}
        stub_put(@client, "products/#{product_id}/custom_fields/#{id}").
            with(:body => options).
            to_return(:body => '', :headers => { :content_type => "application/#{@client.format}" })
        @client.update_custom_field(product_id, id, options)
        expect(a_put(@client, "products/#{product_id}/custom_fields/#{id}").
                   with(:body => options,
                        :headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.delete_custom_field' do
      it 'deletes the product with the given id' do
        product_id = 10
        id = 2
        stub_delete(@client, "products/#{product_id}/custom_fields/#{id}").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.delete_custom_field(product_id, id)
        expect(a_delete(@client, "products/#{product_id}/custom_fields/#{id}").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end
  end

end