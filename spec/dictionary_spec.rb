require 'rspec'
require_relative '../dictionary'

RSpec.shared_examples 'a dictionary' do
  let(:d) { described_class.new }
  let(:keys) { %w[a b c d e f g h i j] }

  it 'works' do
    d.set('a', 1)
    d.set('b', 2)
    d.set('c', 3)
    expect(d.get('a')).to eq 1
    expect(d.get('b')).to eq 2
    expect(d.get('c')).to eq 3
  end

  describe '#get' do
    it 'raises when key not present' do
      expect { d.get('x') }.to raise_error(KeyError, /x/)
      expect { d.get('y') }.to raise_error(KeyError, /y/)
    end
  end

  describe '#keys' do
    it 'returns inserted keys' do
      keys.each { |k| d.set(k, k) }
      expect(d.keys.to_a).to match_array(keys)
    end

    it 'preserves insertion order' do
      keys.each { |k| d.set(k, k) }
      expect(d.keys.to_a).to eq(keys)
    end
  end
end

RSpec.describe LinkedListDictionary do
  it_behaves_like 'a dictionary'
end

RSpec.describe HashTableDictionary do
  it_behaves_like 'a dictionary'
end
