# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'anvil/version'

Gem::Specification.new do |spec|
  spec.name          = 'anvil-core'
  spec.version       = Anvil::VERSION
  spec.authors       = ['Fran Casas', 'Jon de Andres']
  spec.email         = %w(nflamel@gmail.com jondeandres@gmail.com)
  spec.description   = 'Anvil is a tool for building tools.'
  spec.summary       = <<SUMMARY
Anvil is a tool for building tools. A tool that a real craftsmen uses
to build its tools.
SUMMARY
  spec.homepage      = 'http://github.com/anvil-src/anvil-core'
  spec.license       = 'MIT'

  spec.files         = Dir['{bin,lib}/**/*']
  spec.files         += %w(Rakefile README.md LICENSE.txt Gemfile VERSION)
  spec.executables   = %w(anvil)
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = %w(lib)

  # Rubygems version dependency
  spec.required_rubygems_version = '>= 2.1.0'

  # Runtime dependencies
  spec.add_runtime_dependency 'git',   '~> 1.2'
  spec.add_runtime_dependency 'activesupport', '~> 4.1'
  spec.add_runtime_dependency 'mixlib-config', '~> 2.1'
  spec.add_runtime_dependency 'cocaine',   '~> 0.5'
  spec.add_runtime_dependency 'semantic',  '~> 1.3'
  spec.add_runtime_dependency 'rugged',    '~> 0.21.0'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rspec',   '~> 3.0'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'fakefs',  '~> 0.5'
  spec.add_development_dependency 'rubocop', '~> 0.18'
end
