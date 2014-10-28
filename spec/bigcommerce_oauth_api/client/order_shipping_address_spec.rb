require 'spec_helper'
require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/client'

describe BigcommerceOAuthAPI::Client do
  before do
    @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                              :client_id => 'SECRET_ID',
                                              :oauth_token => 'SECRET_TOKEN')
  end

  describe 'Order Shipping Address API' do
    describe '.order_shipping_addresses' do
      it 'should get a list of shipping addresses for the given order' do
        order_id = 10
        stub_get(@client, "orders/#{order_id}/shipping_addresses").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.order_shipping_addresses(order_id)
        expect(a_get(@client, "orders/#{order_id}/shipping_addresses").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.order_shipping_addresses' do
      it 'gets the order shipping address with the given id' do
        order_id = 10
        id = 2
        stub_get(@client, "orders/#{order_id}/shipping_addresses/#{id}").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.order_shipping_address(order_id, id)
        expect(a_get(@client, "orders/#{order_id}/shipping_addresses/#{id}").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end
  end

end