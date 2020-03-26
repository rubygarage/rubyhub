RSpec.describe Hash do
  let(:hash) { { a: true, b: false, c: nil } }

  describe '#except' do
    it 'returns a hash that includes everything except given keys' do
      expect(hash.except(:a, :b)).to eq({ c: nil })
    end

    it 'does not modify initial hash' do
      hash.except(:a, :b)
      expect(hash).to eq(hash)
    end
  end

  describe '#except!' do
    it 'returns a hash that includes everything except given keys' do
      new_hash = hash.dup
      expect(new_hash.except!(:a, :b)).to eq({ c: nil })
    end

    it 'does not modify initial hash' do
      new_hash = hash.dup
      new_hash.except!(:a, :b)
      expect(new_hash).not_to eq(hash)
      expect(new_hash).to eq({ c: nil })
    end
  end
end
