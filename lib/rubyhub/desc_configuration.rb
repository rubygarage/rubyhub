require 'rubyhub/errors'
require 'yaml'
require 'pry'

module Rubyhub
  class DescConfiguration
    attr_reader :main_body

    DESCRIPTION_CONFIG_PATH = 'description.txt'.freeze

    def initialize(template)
      @template = template
      @main_body = File.read(file_name)
    end

    def file_name
      @file_name ||= ".#{@template}_" + DESCRIPTION_CONFIG_PATH
    end
  end
end
