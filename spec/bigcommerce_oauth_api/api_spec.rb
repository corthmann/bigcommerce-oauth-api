require 'spec_helper'
require 'bigcommerce-oauth-api/api'

module BigcommerceOAuthAPI
  describe BigcommerceOAuthAPI::API do
    before do
      @keys = BigcommerceOAuthAPI::Configuration::VALID_OPTIONS_KEYS
    end

    describe 'with module configuration' do
      before do
        BigcommerceOAuthAPI.configure do |config|
          @keys.each do |key|
            config.send("#{key}=", key)
          end
        end
      end

      after do
        BigcommerceOAuthAPI.reset
      end

      it 'should inherit module configuration' do
        api = described_class.new
        @keys.each do |key|
          expect(api.send(key)).to eql(key)
        end
      end

      describe 'with class configuration' do
        before do
          @config = {
              :endpoint => 'a',
              :format => 'b',
              :client_id => 'c',
              :access_token => 'd',
              :adapter => 'e',
              :store_hash => 'f'
          }
        end

        it 'should override module configuration' do
          api = described_class.new
          @config.each do |key, value|
            api.send("#{key}=", value)
          end

          @keys.each do |key|
            expect(api.send("#{key}")).to eql(@config[key])
          end
        end
      end
    end
  end
end