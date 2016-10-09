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

      it 'can set attributes' do
        expect(instance.a).to eq('foo')
        instance.a = 'method'
        expect(instance.a).to eq('method')
        instance['a'] = 'hash'
        expect(instance.a).to eq('hash')
        instance[:a] = 'symbol'
        expect(instance.a).to eq('symbol')
        instance.new_method = 'new stuff'
        expect(instance.new_method).to eq('new stuff')
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

      it 'can set attributes' do
        expect(instance.a.b.c.d).to eq('e')
        instance.a.b.c.d = 'method'
        expect(instance.a.b.c.d).to eq('method')
        instance['a']['b']['c']['d'] = 'hash'
        expect(instance.a.b.c.d).to eq('hash')
        instance[:a][:b][:c][:d] = 'symbol'
        expect(instance.a.b.c.d).to eq('symbol')
        instance.a.b.c.new_method = 'new stuff'
        expect(instance.a.b.c.new_method).to eq('new stuff')
      end

      describe '#marshal_dump' do
        it 'can load a marshal dump correctly' do
          dump = Marshal.dump(instance)
          expect(dump).to be_a String
          loaded_object = Marshal.load(dump)
          expect(loaded_object).to_not be_a String
          expect(loaded_object).to be_a BigcommerceOAuthAPI::Resource
          expect(loaded_object.a.b.c.d).to eql('e')
        end
      end
    end

    context 'when initialized with a list attribute' do
      let(:instance) do
        described_class.new({a: [{b: 1}, {b: 2}] })
      end

      it 'converts the list elements to resources' do
        expect(instance).to be
        expect(instance.respond_to?(:a)).to be true
        expect(instance.a).to be_a Array
        expect(instance.a.size).to eq(2)
        instance.a.each do |entry|
          expect(entry).to be_a BigcommerceOAuthAPI::Resource
          expect(entry.respond_to?(:b)).to be true
        end
      end

      it 'can set attributes' do
        expect(instance.a).to be_a Array
        first_object = instance.a.first
        expect(first_object.b).to eq(1)
        first_object.b = 3
        expect(instance.a.first.b).to eq(3)
        instance[:a][0][:b] = 4
        expect(instance.a.first.b).to eq(4)
        instance['a'][0]['b'] = 5
        expect(instance.a.first.b).to eq(5)
      end

      describe '#marshal_dump' do
        it 'can load a marshal dump correctly' do
          dump = Marshal.dump(instance)
          expect(dump).to be_a String
          loaded_object = Marshal.load(dump)
          expect(loaded_object).to_not be_a String
          expect(loaded_object).to be_a BigcommerceOAuthAPI::Resource
          expect(loaded_object.a).to be_a Array
          expect(loaded_object.a.size).to eq(2)
          loaded_object.a.each do |entry|
            expect(entry).to be_a BigcommerceOAuthAPI::Resource
            expect(entry.respond_to?(:b)).to be true
          end
        end
      end
    end
  end
end
