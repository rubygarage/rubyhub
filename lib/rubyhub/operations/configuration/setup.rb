require 'fileutils'

module Rubyhub
  module Operations
    module Configuration
      class Setup
        TEMPLATE_PATH = 'lib/rubyhub/config/templates/.rubyhub.yml'.freeze
        DESCRIPTION_CONFIG_PATH = 'lib/rubyhub/config/templates/.description.txt'.freeze
        CONFIG_EXISTS_MESSAGE = 'Config already exists!'.freeze
        CONFIG_INSTALLED_MESSAGE = 'Config successfully installed!'.freeze

        class << self
          def call
            initialize_template(TEMPLATE_PATH)
            return if Rubyhub::Configuration.exists?(Rubyhub::Configuration::DESCRIPTION_CONFIG_PATH)

            initialize_config(DESCRIPTION_CONFIG_PATH)
          end

          private

          def initialize_template(file)
            return puts CONFIG_EXISTS_MESSAGE if Rubyhub::Configuration.exists?(Rubyhub::Configuration::CONFIG_PATH)

            initialize_config(file)
            puts CONFIG_INSTALLED_MESSAGE
          end

          def initialize_config(file)
            FileUtils.cp full_template_path(file), target_path, preserve: true, verbose: false
          end

          def full_template_path(file)
            File.join(Rubyhub.root_path, file)
          end

          def target_path
            Dir.pwd
          end
        end
      end
    end
  end
end
