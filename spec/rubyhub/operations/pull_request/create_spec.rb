RSpec.describe Rubyhub::Operations::PullRequest::Create do
  let(:template) { { 'template': 'backend' } }
  let(:options) { { 'template': { 'backend': { 'description_main_body': 'describe your changes here' } } } }
  let(:options_without_desc) { { 'template': { 'backend': { 'labels': 'label' } } } }
  let(:data) { { labels: 'label' } }
  let(:invalid_template) { { 'template': 'backenda' } }
  let(:pull_request) { instance_double('Rubyhub::PullRequest') }
  let(:file) { Dir.pwd + '/' + Rubyhub::Configuration::DESCRIPTION_CONFIG_PATH }

  describe '.call' do
    after do
      File.delete(file) if File.exist?(file)
    end

    context 'when configuration does not exist' do
      it 'raises error message about configuration absence' do
        expect { described_class.call(template) }.to raise_error(Rubyhub::ConfigFileDoesNotExistError) do |ex|
          expect(ex.message).to eq('.rubyhub.yml is not found. Please, provide it.')
        end
      end
    end

    context 'when template name is not provided' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true, true)
        allow(described_class).to receive(:data).and_return('')
      end

      it 'raises error message about template name absence' do
        expect { described_class.call(invalid_template) }.to raise_error(Rubyhub::IncorrectTemplateError) do |ex|
          expect(ex.message).to eq('You haven\'t pass the template name or template name not present in config file')
        end
      end
    end

    context 'when template name is provided' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true)
        allow(described_class).to receive(:data).and_return(data)
      end

      it 'passes data to Rubyhub::PullRequest ' do
        expect(described_class).to receive(:call).with(options)
        described_class.call(options)
      end

      it 'returns instance of Rubyhub::PullRequest ' do
        expect(described_class).to receive(:call).with(options).and_return(pull_request)
        described_class.call(options)
      end
    end

    context 'when description' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true)
        allow(YAML).to receive(:load_file).and_return(options_without_desc)
      end

      it 'is read from file' do
        expect_any_instance_of(Rubyhub::PullRequest).to receive(:create!).and_return(pull_request)

        described_class.call(template)
      end
    end
  end
end
