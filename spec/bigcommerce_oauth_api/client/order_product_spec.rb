require 'spec_helper'
require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/client'

describe BigcommerceOAuthAPI::Client do
  before do
    @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                              :client_id => 'SECRET_ID',
                                              :oauth_token => 'SECRET_TOKEN')
  end

  describe 'Order Products API' do
    describe '.order_products' do
      it 'should get a list of products for the given order' do
        order_id = 10
        stub_get(@client, "orders/#{order_id}/products").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.order_products(order_id)
        expect(a_get(@client, "orders/#{order_id}/products").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.order_product' do
      it 'gets the order product with the given id' do
        order_id = 10
        id = 2
        stub_get(@client, "orders/#{order_id}/products/#{id}").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.order_product(order_id, id)
        expect(a_get(@client, "orders/#{order_id}/products/#{id}").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end
  end

end