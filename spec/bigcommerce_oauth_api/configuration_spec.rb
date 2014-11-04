require 'spec_helper'
require 'bigcommerce-oauth-api/configuration'

module BigcommerceOAuthAPI
  describe BigcommerceOAuthAPI::Configuration do
    after do
      BigcommerceOAuthAPI.reset
    end

    describe '.configure' do
      BigcommerceOAuthAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        it "should set the #{key}" do
          BigcommerceOAuthAPI.configure do |config|
            config.send("#{key}=", key)
            expect(BigcommerceOAuthAPI.send(key)).to eql(key)
          end
        end
      end
    end

    BigcommerceOAuthAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
      describe ".#{key}" do
        it 'should reutrn the default value' do
          expect(BigcommerceOAuthAPI.send(key)).to eql(BigcommerceOAuthAPI::Configuration.const_get("DEFAULT_#{key.upcase}"))
        end
      end
    end
  end
end