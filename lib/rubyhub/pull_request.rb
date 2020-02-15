module Rubyhub
  class PullRequest
    ATTRIBUTES = %i[base_branch labels assignees reviewers description_main_body jira_base_url push open].freeze

    def initialize(options)
      assign_attributes(options)
    end

    def to_command
      build_base_query
      add_branch
      add_labels
      add_assignees
      add_reviewers
      add_push_settings
      add_open_settings
      add_message

      @query
    end

    def create!
      system(to_command)
    end

    private

    def assign_attributes(options)
      ATTRIBUTES.each { |attr| instance_variable_set(:"@#{attr}", options[attr]) }
    end

    def build_base_query
      @query = 'hub pull-request'
    end

    def add_branch
      @query << " -b '#{@base_branch}'" if @base_branch
    end

    def add_labels
      @query << " -l '#{@labels.join(',')}'" if @labels&.any?
    end

    def add_assignees
      @query << " -a '#{@assignees.join(',')}'" if @assignees&.any?
    end

    def add_reviewers
      @query << " -r '#{@reviewers.join(',')}'" if @reviewers&.any?
    end

    def add_push_settings
      @query << ' --push -f' if @push
    end

    def add_open_settings
      @query << ' --browse' if @open
    end

    def add_message
      @query << " -m '#{message}'"
    end

    def branch
      @branch ||= `git rev-parse --symbolic-full-name --abbrev-ref HEAD`
    end

    def parsed_branch
      @parsed_branch ||= branch.split('/')
    end

    def branch_type
      parsed_branch[0].capitalize
    end

    def branch_name
      parsed_branch[1].to_s.upcase
    end

    def jira_ticket
      [data[:jira_base_url], branch_name].join
    end

    def message
      description = "#{branch_type} | #{branch_name.strip}\n\n"
      description << "JIRA ticket - #{jira_ticket}" if data[:jira_base_url]
      description << @description_main_body if @description_main_body
      description
    end
  end
end
