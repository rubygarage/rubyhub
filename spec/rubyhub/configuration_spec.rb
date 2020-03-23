RSpec.describe Rubyhub::Configuration do
  let(:assignees) { 'base_branch'.to_sym }
  let(:options) { { 'default': { 'base_branch': 'master', 'labels': ['bug'] } } }
  let(:file) { Rubyhub::Configuration::CONFIG_PATH }
  let(:setup) { Rubyhub::Operations::Configuration::Setup.call }

  describe '#to_h' do
    it 'converts options to hash' do
      expect(DeepSymbolizeKeysHelper.symbolize_recursive(options).values.first).to have_key(assignees)
    end
  end

  describe '#exists?' do
    context 'when file exist' do
      before do
        setup
      end

      after do
        File.delete(file) if File.exist?(file)
      end

      it 'returns true' do
        expect(File).to exist(file)
      end
    end

    context 'when file does not exist' do
      it 'returns false' do
        expect(File).not_to exist(file)
      end
    end
  end
end
