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

  def file(mode = 'r')
    File.open('VERSION', mode) do |f|
      yield f
    end
  end

  def read_version
    file { |f| f.read.strip }
  end

  def bump(old_version)
    new_version = Anvil::Versioner.new(old_version).bump! term
    Anvil.logger.info "Bumped from #{old_version} to #{new_version}"

    new_version
  end

  def write_version(version)
    file('w+') do |f|
      f.puts version
      f.close
    end
  end
end
