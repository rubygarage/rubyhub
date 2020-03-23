module Rubyhub
  module Operations
    module PullRequest
      class Create
        class << self
          def call(options)
            @template = options[:template]
            raise ConfigFileDoesNotExistError unless Rubyhub::Configuration.exists?
            raise IncorrectTemplateError if !template || !data || data.empty?

            Rubyhub::PullRequest.new(data).create!
          end

          private

          attr_reader :template

          def data
            @data ||= Rubyhub::Configuration.instance.to_h.dig(:template, template.to_sym)
          end
        end
      end
    end
  end
end
