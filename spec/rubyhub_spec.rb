RSpec.describe Rubyhub do
  it 'has a version number' do
    expect(Rubyhub::VERSION).not_to be nil
  end

  it 'runs gracefully' do
    expect { described_class.run }.not_to raise_error
  end
end
