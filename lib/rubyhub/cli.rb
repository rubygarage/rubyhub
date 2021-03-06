require 'thor'

module Rubyhub
  class CLI < Thor
    desc 'init', 'Install basic configuration'
    def init(*_args)
      Operations::Configuration::Setup.call
    end

    desc 'create', 'Create Pull Request'
    method_option :template, aliases: '-t', type: :string
    def create(*_args)
      Operations::PullRequest::Create.call(options)
    end

    def self.exit_on_failure?
      true
    end
  end
end
