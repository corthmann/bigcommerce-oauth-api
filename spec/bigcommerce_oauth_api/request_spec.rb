require 'spec_helper'
require 'bigcommerce-oauth-api/request'
require 'bigcommerce-oauth-api/client'
require 'bigcommerce-oauth-api/resource'

describe BigcommerceOAuthAPI::Request do
  describe '#get' do
    before do
      @client = BigcommerceOAuthAPI::Client.new(
          :store_hash => 'TEST_STORE',
          :client_id => 'SECRET_ID',
          :access_token => 'SECRET_TOKEN')
    end

    context 'given a path and set of options' do
      it 'should perform HTTP GET with OAuth headers' do
        path = '/awesome/1/path/1'
        options = { foo: 'bar', bar: { oof: 'rab' } }
        url = @client.send(:connection).build_url(path).to_s
        stub_request(:get, url).to_return(:status => 200, :body => options.to_json, :headers => {
                                                            content_type: 'application/json' })

        expect(@client.get(path, {})).to eql(BigcommerceOAuthAPI::Resource.new(options))
        expect(a_request(:get, url).
            with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end

    context 'given a request that returns no content' do
      it 'returns nil' do
        path = '/awesome/1/path/1'
        url = @client.send(:connection).build_url(path).to_s
        stub_request(:get, url).to_return(:status => 204, :body => '', :headers => { content_type: 'application/json' })

        expect(@client.get(path, {})).to eql(nil)
        expect(a_request(:get, url).
                   with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                     'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made

      end
    end

  end
end