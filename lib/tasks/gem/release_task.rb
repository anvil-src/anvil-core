require 'anvil/task'
require 'anvil/rubygems'

class Gem::ReleaseTask < Anvil::Task
  description 'Builds a new version and pushes it to rubygems'

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
    Gem::BumpTask.new(bump_term, persist: true).task
  end

  def build
    Gem::BuildTask.new(gemspec_file, options).task
  end

  def push(gem_file, version)
    logger.info "Pushing version #{version} to rubygems"
    Anvil::Rubygems.push gem_file
  end
end
