module Rubyhub
  class ConfigFileDoesNotExistError < StandardError
    def message
      '.rubyhub.yml is not found. Please, provide it.'
    end
  end

  class IncorrectTemplateError < StandardError
    def message
      'You haven\'t pass the template name or template name not present in config file'
    end
  end
end
