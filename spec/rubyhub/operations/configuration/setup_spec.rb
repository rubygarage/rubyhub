RSpec.describe Rubyhub::Operations::Configuration::Setup do
  let(:temporary_path) { "#{Dir.pwd}/spec/" }
  let(:config) { '.rubyhub.yml' }
  let(:desc_config) { '.description.txt' }

  before do
    allow(Dir).to receive(:pwd).and_return(temporary_path)
  end

  after do
    path_to_temporary_config = "#{temporary_path}#{config}"
    File.delete(path_to_temporary_config) if File.exist?(path_to_temporary_config)

    path_to_desc_file = "#{temporary_path}#{desc_config}"
    File.delete(path_to_desc_file) if File.exist?(path_to_desc_file)
  end

  describe '.call' do
    context 'when configuration already exists' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true)
      end

      it 'puts message about existing configuration' do
        expect { described_class.call }.to output(described_class::CONFIG_EXISTS_MESSAGE + "\n").to_stdout
      end
    end

    context 'when there is no configuration' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(false)
      end

      it 'puts message about successfully installed configuration' do
        expect { described_class.call }.to output(described_class::CONFIG_INSTALLED_MESSAGE + "\n").to_stdout
      end
    end
  end
end
