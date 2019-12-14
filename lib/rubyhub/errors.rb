module Rubyhub
  class ConfigFileDoesNotExistError < StandardError
    def message
      '.rubyhub.yml is not found. Please, provide it.'
    end
  end
end
