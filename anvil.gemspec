# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'anvil/version'

Gem::Specification.new do |spec|
  spec.name          = 'anvil'
  spec.version       = Anvil::VERSION
  spec.authors       = ['Fran Casas', 'Jon de Andres']
  spec.email         = %w(nflamel@otrobloggeek.com jondeandres@gmail.com)
  spec.description   = 'Anvil is a tool for building tools.'
  spec.summary       = <<SUMMARY
Anvil is a tool for building tools. A tool that a real craftsmen uses to build its tools.
SUMMARY
  spec.homepage      = 'http://github.com/franciscoj/anvil'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = %w(lib)

  # Runtime dependencies
  spec.add_runtime_dependency     'git',           '~> 1.2'
  spec.add_runtime_dependency     'activesupport', '~> 4.0'
  spec.add_runtime_dependency     'mixlib-config', '~> 2.1'
  spec.add_runtime_dependency     'cocaine',       '~> 0.5'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake',    '~> 10.1'
  spec.add_development_dependency 'rspec',   '~> 2.14'
  spec.add_development_dependency 'byebug',  '~> 2.6'
  spec.add_development_dependency 'fakefs',  '~> 0.5'
  spec.add_development_dependency 'rubocop', '~> 0.18'
end
