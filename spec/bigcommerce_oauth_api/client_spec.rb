require 'spec_helper'
require 'bigcommerce_oauth_api/client'

module BigcommerceOAuthAPI
  describe BigcommerceOAuthAPI::Client do
    before do
      @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                                :client_id => 'SECRET_ID',
                                                :access_token => 'SECRET_TOKEN')
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

  end
end