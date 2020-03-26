RSpec.describe Rubyhub::Operations::PullRequest::Create do
  let(:options) { { 'template': 'backend' } }
  let(:invalid_template) { { 'template': 'backenda' } }
  let(:file) { ".#{options[:template]}_" + Rubyhub::DescConfiguration::DESCRIPTION_CONFIG_PATH }

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

    context 'when given incorrect template name' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true)
      end

      it 'raises error message about template name absence' do
        expect { described_class.call(invalid_template) }.to raise_error(Rubyhub::IncorrectTemplateNameError) do |ex|
          expect(ex.message).to eq('You\'ve passed incorrect template name. Please, provide appropriate one')
        end
      end
    end

    context 'when template name is not provided' do
      before do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true, false)
        allow(described_class).to receive(:add_description_to_data).and_return('')
      end

      it 'raises error message about template name absence' do
        expect { described_class.call(options) }.to raise_error(Rubyhub::IncorrectTemplateError) do |ex|
          expect(ex.message).to eq('You haven\'t pass the template name or template name not present in config file')
        end
      end
    end
  end
end
