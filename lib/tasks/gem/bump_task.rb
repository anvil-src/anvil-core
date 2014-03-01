require 'anvil/task'
require 'anvil/versioner'

class Gem::BumpTask < Anvil::Task
  description "Bumps a gem's version"

  parser do
    arguments %w[term]
  end

  attr_reader :term

  def initialize(term, options = {})
    @term = term
  end

  def task
    version = bump(read_version)
    write_version version

    version
  end

  protected

  def file
    @file ||= File.open('VERSION', 'w+')
  end

  def read_version
    file.read
  end

  def bump(old_version)
    new_version = Anvil::Versioner.new(old_version).bump! term
    Anvil.logger.info "Bumped from #{old_version} to #{new_version}"

    new_version
  end

  def write_version(version)
    file.puts version
    file.close
  end
end
