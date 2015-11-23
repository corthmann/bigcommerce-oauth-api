require 'spec_helper'
require 'bigcommerce-oauth-api'

describe Faraday::Response do
  before do
    @client = BigcommerceOAuthAPI::Client.new(:store_hash => 'TEST_STORE',
                                              :client_id => 'SECRET_ID',
                                              :access_token => 'SECRET_TOKEN')
  end

  {
      400 => BigcommerceOAuthAPI::BadRequest,
      401 => BigcommerceOAuthAPI::Unauthorized,
      403 => BigcommerceOAuthAPI::Forbidden,
      404 => BigcommerceOAuthAPI::NotFound,
      405 => BigcommerceOAuthAPI::MethodNotAllowed,
      406 => BigcommerceOAuthAPI::NotAcceptable,
      409 => BigcommerceOAuthAPI::Conflict ,
      413 => BigcommerceOAuthAPI::RequestEntityTooLarge,
      415 => BigcommerceOAuthAPI::UnsupportedMediaType,
      429 => BigcommerceOAuthAPI::TooManyRequests,
      500 => BigcommerceOAuthAPI::InternalServerError,
      501 => BigcommerceOAuthAPI::NotImplemented,
      502 => BigcommerceOAuthAPI::BadGateway,
      503 => BigcommerceOAuthAPI::ServiceUnavailable,
      507 => BigcommerceOAuthAPI::InsufficientStorage,
      509 => BigcommerceOAuthAPI::BandwidthLimitExceeded
  }.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_get(@client, 'products/1337').to_return(:body => '', :status => status)
      end

      it "should raise #{exception.name} error" do
        expect{ @client.product(1337) }.to raise_error(exception)
      end
    end
  end

  context 'when the api limit is hit' do
    it 'raises a TooManyRequests error' do
      stub_get(@client, 'products').
          to_return(:body => '', :status => 429, :headers => { 'X-Retry-After' => 15 })
      expect{ @client.products }.to raise_error(BigcommerceOAuthAPI::TooManyRequests, '15')
    end
  end
end
