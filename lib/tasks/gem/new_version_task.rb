require 'anvil/task'
require 'anvil/rubygems'

class Gem::NewVersionTask < Anvil::Task
  description 'Builds a new version an pushes to rubygems'

  parser do
    arguments %w[bump_term]

    on('-i', '--[no-]install', 'Install gem') do |i|
      options[:install] = i
    end
  end

  attr_reader :bump_term, :options

  def initialize(bump_term, options = {})
    @bump_term = bump_term
    @options = options
  end

  def task
    version  = bump
    gem_file = build

    push gem_file, version
  end

  protected

  def gemspec_file
    Dir['*.gemspec'].first
  end

  def bump
    @version = Gem::BumpTask.new(bump_term).task
  end

  def build
    Gem::BuildTask.new(gemspec_file, options).task
  end

  def push(gem_file, version)
    Anvil.logger.info "Pushing version #{version} to rubygems"
    Anvil::Rubygems.push gem_file
  end
end
