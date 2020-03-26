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

  class IncorrectTemplateNameError < StandardError
    def message
      'You\'ve passed incorrect template name. Please, provide appropriate one'
    end
  end
end
