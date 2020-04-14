RSpec.describe Rubyhub::PullRequest do
  let(:base_branch) { 'master' }
  let(:base_branch_query) { "-b '#{base_branch}'" }
  let(:label) { 'needs review' }
  let(:label_query) { "-l '#{label}'" }
  let(:fake_user_name) { FFaker::Internet.user_name }
  let(:assignees_query) { "-a '#{fake_user_name}'" }
  let(:reviewers_query) { "-r '#{fake_user_name}'" }
  let(:jira_base_url) { 'https://sample.atlassian.net/browse/' }
  let(:description_main_body) { FFaker::Lorem.sentence }
  let(:current_branch) { 'feature/PEO-123'.strip.capitalize }
  let(:current_branch_type) { current_branch.split('/')[0] }
  let(:current_branch_name) { current_branch.split('/')[1]&.upcase }

  let(:params) do
    {
      base_branch: base_branch,
      labels: [label],
      assignees: [fake_user_name],
      reviewers: [fake_user_name],
      description_main_body: description_main_body,
      jira_base_url: jira_base_url,
      push: true,
      open: true
    }
  end
  let(:query_params) do
    [
      'hub pull-request',
      base_branch_query,
      label_query,
      assignees_query,
      reviewers_query,
      "-m '#{current_branch_type} | #{current_branch_name}\n\nJIRA ticket - #{jira_base_url}#{current_branch_name}\n
#{description_main_body}'",
      '--push -f',
      '--browse'
    ]
  end

  let(:query) { query_params.join(' ') }

  describe '#to_command' do
    before do
      allow_any_instance_of(described_class).to receive(:branch).and_return(current_branch)
    end

    context 'when passed all params' do
      it 'sets full query' do
        expect(described_class.new(params).to_command).to eq(query)
      end
    end

    context 'when missing some params' do
      let(:smaller_list_of_params) { params.except(:assignees, :reviewers) }
      let(:smaller_query_params) { query_params - [assignees_query, reviewers_query] }
      let(:smaller_query) { smaller_query_params.join(' ') }

      it 'sets query only for defined params' do
        expect(described_class.new(smaller_list_of_params).to_command).to eq(smaller_query)
      end
    end

    context 'when some params expected to be an array passed as string' do
      let(:params_without_arrays) { params.merge(labels: label, assignees: fake_user_name, reviewers: fake_user_name) }

      it 'still sets full relevant query' do
        expect(described_class.new(params_without_arrays).to_command).to eq(query)
      end
    end
  end

  describe '#create!' do
    it 'calls to_command to build the query' do
      expect_any_instance_of(described_class).to receive(:to_command).and_return('')
      described_class.new(params).create!
    end
  end
end
