RSpec.describe String do
  describe '#to_a' do
    it 'puts string into array' do
      expect('string'.to_a).to eq(['string'])
    end
  end
end
