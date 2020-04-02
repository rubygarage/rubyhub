require 'rubyhub/errors'
require 'singleton'
require 'yaml'
require 'pry'

module Rubyhub
  class Configuration
    include Singleton
    attr_reader :options, :main_body

    CONFIG_PATH = '.rubyhub.yml'.freeze
    DESCRIPTION_CONFIG_PATH = '.description.txt'.freeze

    def initialize
      @options = self.class.exists?(CONFIG_PATH) ? load_from_file : {}
      @main_body = File.exist?(DESCRIPTION_CONFIG_PATH) ? read_description_from_file : {}
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

    def read_description_from_file
      File.read(Dir.pwd + '/' + DESCRIPTION_CONFIG_PATH)
    end
  end
end
