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
  spec.post_install_message = 'Please install https://github.com/github/hub in order to use Rubyhub!'

  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
end
