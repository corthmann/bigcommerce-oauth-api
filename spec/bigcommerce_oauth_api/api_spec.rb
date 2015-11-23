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
              :store_hash => 'f',
              :if_modified_since => 'i',
              :typecast_to_resource => 'j',
              :user_name => 'g',
              :api_key => 'h',
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

    describe '#is_legacy?' do

      after do
        BigcommerceOAuthAPI.reset
      end

      context 'given the default configuration' do
        it 'should return false' do
          expect(described_class.new.is_legacy?).to eql(false)
        end
      end

      context 'given a legacy configuration' do
        describe 'with module configuration' do
          before do
            BigcommerceOAuthAPI.configure do |config|
              [:endpoint, :user_name, :api_key].each do |key|
                config.send("#{key}=", key)
              end
            end
          end

          it 'should return true' do
            expect(described_class.new.is_legacy?).to eql(true)
          end
        end

        describe 'with class configuration' do
          it 'should return true' do
            expect(described_class.new({ :endpoint => 'c', :user_name => 'd', :api_key => 'f' }).is_legacy?).to eql(true)
          end
        end
      end

      context 'given an oauth configuration' do
        describe 'with module configuration' do
          before do
            BigcommerceOAuthAPI.configure do |config|
              [:client_id, :access_token, :store_hash].each do |key|
                config.send("#{key}=", key)
              end
            end
          end

          it 'should return true' do
            expect(described_class.new.is_legacy?).to eql(false)
          end
        end

        describe 'with class configuration' do
          it 'should return true' do
            expect(described_class.new({ :client_id => 'c', :access_token => 'd', :store_hash => 'f' }).is_legacy?).to eql(false)
          end
        end
      end
    end
  end
end