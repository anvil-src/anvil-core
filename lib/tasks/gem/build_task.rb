require 'fileutils'
require 'anvil/task'
require 'anvil/rubygems'

class Gem::BuildTask < Anvil::Task
  description 'Builds a gem for you and can install it on your system.'

  parser do
    arguments %w[gemspec_file]

    on('-i', '--[no-]install', 'Install gem') do |i|
      options[:install] = i
    end
  end

  attr_reader :gemspec_file, :options

  def initialize(gemspec_file, options = {})
    @gemspec_file = gemspec_file
    @options = options
  end

  def task
    path = File.dirname(gemspec_file)

    Dir.chdir(path) do
      gem_file = build_gem(gemspec_file)
      Anvil::Rubygems.install gem_file if install?

      gem_file
    end
  end

  def build_gem(gemspec_file)
    rubygems_output = Anvil::Rubygems.build(gemspec_file)
    gem_file        = extract_gem_file(rubygems_output)

    FileUtils.mkdir_p('pkg')
    FileUtils.move(gem_file, 'pkg')

    File.expand_path("pkg/#{gem_file}")
  end

  def extract_gem_file(output)
    output.match(/File: (.*)$/)[1]
  end

  def install?
    options.fetch(:install, true)
  end
end
