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
            @data ||= Rubyhub::Configuration.instance.options.dig(:template, template.to_sym)
            return unless @data.respond_to?(:to_hash)

            description = @data[:description_main_body]
            add_description_to_data if description.nil? || description.empty?
            @data
          end

          def add_description_to_data
            @data[:description_main_body] = Rubyhub::Configuration.instance.main_body
          end
        end
      end
    end
  end
end
