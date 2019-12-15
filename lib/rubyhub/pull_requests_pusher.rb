require 'rubyhub/default_info_loader'

module Rubyhub
  class PullRequestsPusher
    class << self
      def call
        build_base_query
        add_branch
        add_labels
        add_assignees
        add_message
        add_push_settings
        create!
      end

      private

      def default_info
        @default_info ||= DefaultInfoLoader.call
      end

      def build_base_query
        @query = 'hub pull-request'
      end

      def add_branch
        @query << " -b '#{default_info[:base_branch]}'"
      end

      def add_labels
        @query << " -l '#{default_info[:label]}'"
      end

      def add_assignees
        @query << " -a '#{default_info[:assignees].join(',')}'"
      end

      def add_push_settings
        @query << ' --push -f'
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
        parsed_branch[1]&.upcase || branch_type
      end

      def jira_ticket
        [default_info[:jira_base_url], branch_name].join
      end

      def create!
        system(@query)
      end

      def message
        description = "#{branch_type} | #{branch_name.strip}\n\n"
        description << "JIRA ticket - #{jira_ticket}" if default_info[:jira_base_url]
        description << default_info[:description_main_body] if default_info[:description_main_body]
        description
      end
    end
  end
end
