  RSpec.describe Rubyhub::Operations::PullRequest::Create do
    let(:options) { { template: 'your_template_name' } }

    describe '.call' do
      context 'when raises error' do
        it 'file doesnt exist' do
          binding.pry
          expect { described_class.call(options) }.to raise_error(ConfigFileDoesNotExistError)
        end

        it 'when template or data is absent' do
          binding.pry
          allow(Rubyhub::Configuration).to receive(:exists?).and_return(true)
          expect { described_class.call(options) }.to raise_error(IncorrectTemplateError)
        end
      end
    end
  end
