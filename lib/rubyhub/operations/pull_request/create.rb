module Rubyhub
  module Operations
    module PullRequest
      class Create
        class << self
          def call(options)
            @template = options[:template]

            raise ConfigFileDoesNotExistError unless Rubyhub::Configuration.exists?(Rubyhub::Configuration::CONFIG_PATH)
            raise IncorrectTemplateError if !template || !data || data.empty?

            Rubyhub::PullRequest.new(data).create!
          end

          private

          attr_reader :template

          def data
            @data ||= Rubyhub::Configuration.instance.options.dig(:template, template.to_sym)
            description = @data[:description_main_body] if @data
            add_description_to_data if description.nil? || description.empty?
            @data
          end

          def add_description_to_data
            @data[:description_main_body] = Rubyhub::Configuration.instance.main_body
          rescue NoMethodError => e
            e.message
          end
        end
      end
    end
  end
end
