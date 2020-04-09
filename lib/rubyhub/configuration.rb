require 'rubyhub/errors'
require 'singleton'
require 'yaml'
require 'pry'

module Rubyhub
  class Configuration
    include Singleton
    attr_reader :options

    CONFIG_PATH = '.rubyhub.yml'.freeze

    def initialize
      @options = self.class.exists? ? load_from_file : {}
    end

    class << self
      def exists?
        File.exist?(CONFIG_PATH)
      end
    end

    private

    def load_from_file
      DeepSymbolizeKeysHelper.symbolize_recursive(YAML.load_file(CONFIG_PATH) || {})
    end
  end
end
