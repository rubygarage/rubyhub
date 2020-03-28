RSpec.describe Rubyhub::Operations::PullRequest::Create do
  let(:options) { { 'template': 'backend' } }
  let(:data) { { labels: 'label' } }
  let(:invalid_template) { { 'template': 'backenda' } }
  let(:file) { Dir.pwd + Rubyhub::Configuration::DESCRIPTION_CONFIG_PATH }

  describe '.call' do
    after do
      File.delete(file) if File.exist?(file)
    end

    context 'when configuration does not exist' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(false)
      end

      it 'raises error message about configuration absence' do
        expect { described_class.call(options) }.to raise_error(Rubyhub::ConfigFileDoesNotExistError) do |ex|
          expect(ex.message).to eq('.rubyhub.yml is not found. Please, provide it.')
        end
      end
    end

    context 'when template name is not provided' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true, false)
        allow(described_class).to receive(:initialize_description_file).and_raise(Rubyhub::IncorrectTemplateError)
      end

      it 'raises error message about template name absence' do
        expect { described_class.call(invalid_template) }.to raise_error(Rubyhub::IncorrectTemplateError) do |ex|
          expect(ex.message).to eq('You haven\'t pass the template name or template name not present in config file')
        end
      end
    end

    context 'when template name is provided' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true, true)
        allow(described_class).to receive(:data).and_return(data)
      end

      it 'passes data to Rubyhub::PullRequest ' do
        expect(described_class).to receive(:call).with(options).and_call_original
        described_class.call(options)
      end
    end
  end
end
