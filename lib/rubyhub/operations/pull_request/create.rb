module Rubyhub
  module Operations
    module PullRequest
      class Create
        TEMPLATE_PATH = 'lib/rubyhub/config/templates'.freeze

        class << self
          def call(options)
            @template = options[:template]

            check_config_existence

            check_template_name_validity

            check_template_existence

            Rubyhub::PullRequest.new(data).create!
          end

          private

          attr_reader :template

          def data
            @data ||= Rubyhub::Configuration.instance.options.dig(:template, template.to_sym)
            add_description_to_data
            @data
          end

          def check_config_existence
            raise ConfigFileDoesNotExistError unless Rubyhub::Configuration.exists?
          end

          def check_template_name_validity
            raise IncorrectTemplateNameError unless initialize_description_file
          end

          def check_template_existence
            raise IncorrectTemplateError if !template || !data || data.empty?
          end

          def add_description_to_data
            description = Rubyhub::DescConfiguration.new(template)
            @data[:description_main_body] = description.main_body
          end

          def initialize_description_file
            FileUtils.cp full_template_path, target_path, preserve: true, verbose: false
          rescue Errno::ENOENT => e
            warn e.message
          end

          def full_template_path
            File.join(Rubyhub.root_path, (TEMPLATE_PATH + file_name))
          end

          def target_path
            Dir.pwd + file_name
          end

          def file_name
            "/.#{@template}_" + Rubyhub::DescConfiguration::DESCRIPTION_CONFIG_PATH
          end
        end
      end
    end
  end
end
