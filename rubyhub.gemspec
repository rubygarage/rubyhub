lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubyhub/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubyhub'
  spec.version       = Rubyhub::VERSION
  spec.authors       = ['Denis Zemlianoy', 'Vsevolod Voloshyn']
  spec.email         = ['']

  spec.summary       = "Tool for faster creation of GitHub's Pull Requests"
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.post_install_message = '
    Note that Rubyhub requires additional dependencies!

    Please install https://github.com/github/hub
  '

  spec.add_dependency 'thor', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'fasterer', '~> 0.8'
  spec.add_development_dependency 'ffaker', '~> 2.14'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4'
  spec.add_development_dependency 'rubocop', '~> 0.80'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.38'
  spec.add_development_dependency 'simplecov', '~> 0.15', '< 0.18'
end
