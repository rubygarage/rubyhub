module Rubyhub
  module Operations
    module PullRequest
      class Create
        class << self
          def call(options)
            @options = options

            build_base_query
            add_branch
            add_labels
            add_assignees
            add_message
            add_push_settings
            create!
          end

          private

          def data
            @data ||= Rubyhub::Configuration.to_h
          end

          def build_base_query
            @query = 'hub pull-request'
          end

          def add_branch
            @query << " -b '#{@data[:base_branch]}'"
          end

          def add_labels
            @query << " -l '#{@data[:label]}'"
          end

          def add_assignees
            @query << " -a '#{@data[:assignees].join(',')}'"
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
            [data[:jira_base_url], branch_name].join
          end

          def create!
            system(@query)
          end

          def message
            description = "#{branch_type} | #{branch_name.strip}\n\n"
            description << "JIRA ticket - #{jira_ticket}" if data[:jira_base_url]
            description << @data[:description_main_body] if @data[:description_main_body]
            description
          end
        end
      end
    end
  end
end
