require 'fileutils'

module Rubyhub
  module Operations
    module Configuration
      class Setup
        TEMPLATE_PATH = 'lib/rubyhub/config/templates/.rubyhub.yml'.freeze
        CONFIG_EXISTS_MESSAGE = 'Config already exists!'.freeze
        CONFIG_INSTALLED_MESSAGE = 'Config successfully installed!'.freeze

        class << self
          def call
            return puts CONFIG_EXISTS_MESSAGE if Rubyhub::Configuration.exists?

            initialize_config
            puts CONFIG_INSTALLED_MESSAGE
          end

          private

          def initialize_config
            FileUtils.cp full_template_path, target_path, preserve: true, verbose: false
          end

          def full_template_path
            File.join(Rubyhub.root_path, TEMPLATE_PATH)
          end

          def target_path
            Dir.pwd
          end
        end
      end
    end
  end
end
