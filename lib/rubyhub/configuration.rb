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
      binding.pry
      @options = self.class.exists? ? load_from_file : {}
    end

    # def to_h
    #   binding.pry
    #   @options.to_h
    # end

    class << self
      def exists?
        binding.pry
        File.exist?(CONFIG_PATH)
      end
    end

    private

    def load_from_file
      binding.pry
      DeepSymbolizeKeysHelper.symbolize_recursive(YAML.load_file(CONFIG_PATH) || {})
    end
  end
end
