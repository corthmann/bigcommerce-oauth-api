require 'spec_helper'
require 'bigcommerce-oauth-api/resource'

module BigcommerceOAuthAPI
  describe BigcommerceOAuthAPI::Resource do
    context 'when initialized with a hash' do
      let(:instance) do
        described_class.new({ a: 'foo', b: 'bar', c: { foo: 'bar'} })
      end

      it 'responds to the methods corresponding to the hash keys' do
        expect(instance.respond_to?(:a)).to eql(true)
        expect(instance.respond_to?(:b)).to eql(true)
        expect(instance.respond_to?(:c)).to eql(true)
      end

      it 'returns the correct values when accessing through methods' do
        expect(instance.a).to eql('foo')
        expect(instance.b).to eql('bar')
        expect(instance.c).to be_a Resource
        expect(instance.c['foo']).to eql('bar')
        expect(instance.c[:foo]).to eql('bar')
        expect(instance.c.foo).to eql('bar')
      end
    end

    context 'when initialized with a deeply nested hash' do
      let(:instance) do
        described_class.new({a: { b: { c: { d: 'e' } } } })
      end

      it 'responds to both methods and keys on all level' do
        expect(instance.respond_to?(:a)).to eql(true)
        expect(instance.a.respond_to?(:b)).to eql(true)
        expect(instance.a.b.respond_to?(:c)).to eql(true)
        expect(instance.a.b.c.respond_to?(:d)).to eql(true)
        expect(instance[:a][:b][:c][:d]).to eql('e')
        expect(instance['a']['b']['c']['d']).to eql('e')
        expect(instance.a.b.c.d).to eql('e')
      end
    end
  end
end
