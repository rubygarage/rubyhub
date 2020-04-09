RSpec.describe Rubyhub::Operations::PullRequest::Create do
  let(:options) { { template: 'your_template_name' } }

  describe '.call' do
    context 'when raises error' do
      it 'file doesnt exist' do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(false)
        expect { described_class.call(options) }.to raise_error(Rubyhub::ConfigFileDoesNotExistError)
      end

      it 'when template or data is absent' do
        allow(Rubyhub::Configuration).to receive(:exists?).and_return(true)
        expect { described_class.call(options) }.to raise_error(Rubyhub::IncorrectTemplateError)
      end
    end
  end
end
