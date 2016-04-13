require 'rspec'
require_relative '../dictionary'

RSpec.shared_examples 'a dictionary' do
  it 'works' do
    d = described_class.new
    d.set('a', 1)
    d.set('b', 2)
    d.set('c', 3)
    expect(d.get('a')).to eq 1
    expect(d.get('b')).to eq 2
    expect(d.get('c')).to eq 3
    expect { d.get('x') }.to raise_error(KeyError, /x/)
    expect { d.get('y') }.to raise_error(KeyError, /y/)
  end
end

RSpec.describe LinkedListDictionary do
  it_behaves_like 'a dictionary'
end

RSpec.describe HashTableDictionary do
  it_behaves_like 'a dictionary'
end
