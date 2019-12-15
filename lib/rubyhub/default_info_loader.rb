require 'rubyhub/errors'
require 'yaml'

module Rubyhub
  class DefaultInfoLoader
    DOTFILE = '.rubyhub.yml'.freeze

    class << self
      def call
        return nonexistent_file unless file_exists?

        load_yaml_info
      end

      private

      def file_exists?
        File.exist?(DOTFILE)
      end

      def nonexistent_file
        raise ConfigFileDoesNotExistError
      end

      def load_yaml_info
        YAML.load_file(DOTFILE).transform_keys(&:to_sym)
      end
    end
  end
end
