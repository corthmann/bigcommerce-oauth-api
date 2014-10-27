require 'bigcommerce_oauth_api/request'
require 'bigcommerce_oauth_api/client'

describe BigcommerceOAuthAPI::Request do
  describe '#get' do
    context 'given a path and set of options' do
      it 'should perform HTTP GET with OAuth headers' do
        client = BigcommerceOAuthAPI::Client.new(:client_id => 'SECRET_ID', :oauth_token => 'SECRET_TOKEN')
        path = '/awesome/1/path/1'
        url = client.send(:connection).build_url(path).to_s
        stub_request(:get, url).to_return(:status => 200, :body => '', :headers => {})

        client.get(path, {})
        expect(a_request(:get, url).
            with(:headers => {'X-Auth-Client' => 'SECRET_ID',
                                               'X-Auth-Token' => 'SECRET_TOKEN'})).to have_been_made
      end
    end
  end
end