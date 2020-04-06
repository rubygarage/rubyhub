require 'rubyhub/errors'
require 'singleton'
require 'yaml'
require 'pry'

module Rubyhub
  class Configuration
    include Singleton
    attr_reader :options, :main_body

    CONFIG_PATH = '.rubyhub.yml'.freeze

    def initialize
      @options = self.class.exists? ? load_from_file : {}
      @main_body = File.exist?(description_path) ? read_description_from_file : {}
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

    def description_path
      @description = options.dig(:template, :default, :description_path) || ''
    end

    def read_description_from_file
      File.read(description_path)
    end
  end
end
