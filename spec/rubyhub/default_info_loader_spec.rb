RSpec.describe Rubyhub::DefaultInfoLoader do
  describe '.call' do
    context 'when config file exists' do
      it 'returns hash' do
        expect(described_class.call).to be_a Hash
      end
    end

    context 'when config file does not exist' do
      before do
        stub_const('Rubyhub::DefaultInfoLoader::DOTFILE', 'random_name')
      end

      it 'raises ConfigFileDoesNotExistError' do
        expect { described_class.call }.to raise_error(Rubyhub::ConfigFileDoesNotExistError)
      end
    end
  end
end
