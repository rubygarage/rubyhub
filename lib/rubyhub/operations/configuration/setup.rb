require 'fileutils'

module Rubyhub
  module Operations
    module Configuration
      class Setup
        TEMPLATE_PATH = 'lib/rubyhub/config/templates/.rubyhub.yml'.freeze

        class << self
          def call
            if Rubyhub::Configuration.exists?
              puts 'Config already exists!'
            else
              initialize_config
              puts 'Config successfully installed!'
            end
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
