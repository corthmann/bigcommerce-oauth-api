require 'spec_helper'
require 'bigcommerce_oauth_api'
require 'bigcommerce_oauth_api/client'

describe BigcommerceOAuthAPI::Client do
  describe '.products' do
    before do
      @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                                :client_id => 'SECRET_ID',
                                                :oauth_token => 'SECRET_TOKEN')
    end

    it 'should get first products' do
      stub_get(@client, 'products').
          to_return(:body => '', :headers => {
          :content_type => "application/#{@client.format}"})
      @client.products
      expect(a_get(@client, 'products').
                 with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                   'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
    end
  end
end
