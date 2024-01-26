# frozen_string_literal: true

require_relative 'lib/doorloop/version'

Gem::Specification.new do |spec|
  spec.name          = 'doorloop'
  spec.version       = Doorloop::VERSION
  spec.authors       = ['MezbahAlam']
  spec.email         = ['mezbahalam26@gmail.com']

  spec.summary       = 'A simple wrapper for the DoorLoop API'
  spec.description   = 'A Ruby client for the DoorLoop API, allowing easy access to its resources.'
  spec.homepage      = 'https://github.com/mezbahalam/doorloop'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mezbahalam/doorloop'
  spec.metadata['changelog_uri'] = 'https://github.com/mezbahalam/doorloop/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '~> 2.0'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'webmock', '~> 3.19.1'
end
