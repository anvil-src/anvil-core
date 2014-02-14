# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alfred/version'

Gem::Specification.new do |spec|
  spec.name          = "alfred"
  spec.version       = Alfred::VERSION
  spec.authors       = ['Fran Casas', 'Jon de Andres']
  spec.email         = %w(nflamel@otrobloggeek.com jondeandres@gmail.com)
  spec.description   = 'Alfred Pennyworth. A gem to help us with our daily superhero tasks'
  spec.summary       = 'Alfred Pennyworth. A gem to help us with our daily superhero tasks'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  # Runtime dependencies
  spec.add_runtime_dependency     'git'
  spec.add_runtime_dependency     'activesupport', '~> 4.0'
  spec.add_runtime_dependency     'mixlib-config', '~> 2.1.0'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'fakefs', '~> 0.5.0'
end
