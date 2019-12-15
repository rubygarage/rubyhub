require 'rubyhub/utils/deep_symbolize_keys_helper'

using DeepSymbolizeKeysHelper

require 'rubyhub/configuration'
require 'rubyhub/pull_request'

require 'rubyhub/operations/configuration/setup'
require 'rubyhub/operations/pull_request/create'

module Rubyhub
  def self.root_path
    File.dirname(__dir__)
  end
end
