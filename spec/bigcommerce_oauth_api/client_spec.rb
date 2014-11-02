require 'spec_helper'
require 'bigcommerce_oauth_api/client'
require 'bigcommerce_oauth_api/error'

module BigcommerceOAuthAPI
  describe BigcommerceOAuthAPI::Client do
    before do
      @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                                :client_id => 'SECRET_ID',
                                                :access_token => 'SECRET_TOKEN')
    end

    describe 'when using with_api_methods' do
      context 'and one of those actions would overwrite a defined method' do
        it 'raises MethodAlreadyDefinedError' do
          # The required client attempts to overwrite the 'post' method which is used to make HTTP POST requests
          expect {
            require 'support/method_already_defined_client'
          }.to raise_error(BigcommerceOAuthAPI::MethodAlreadyDefinedError, "Method already defined: 'post'")
        end
      end

      context 'and two api definitions would define methods with the same name' do
        it 'raises MethodAlreadyDefinedError' do
          # The required client has duplicate api definitions
          expect {
            require 'support/duplicate_api_definition_client'
          }.to raise_error(BigcommerceOAuthAPI::MethodAlreadyDefinedError, "Method already defined: 'states'")
        end
      end
    end

    describe '.time' do
      it 'returns the server time' do
        stub_get(@client, 'time').
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.time
        expect(a_get(@client, 'time').
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.store_information' do
      it 'returns the store information' do
        stub_get(@client, 'store').
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.store_information
        expect(a_get(@client, 'store').
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    describe '.product_googleproductsearch' do
      it 'returns the google product search mappings for a product' do
        product_id = 10
        stub_get(@client, "products/#{product_id}/googleproductsearch").
            to_return(:headers => { :content_type => "application/#{@client.format}" })
        @client.product_googleproductsearch(product_id)
        expect(a_get(@client, "products/#{product_id}/googleproductsearch").
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

  end
end