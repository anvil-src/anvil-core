require 'anvil/task'
require 'anvil/versioner'

class GemBumpTask < Anvil::Task
  description "Bumps a gem's version"

  parser do
    arguments %w[term]
  end

  attr_reader :term

  def initialize(term, options = {})
    @term = term
  end

  def task
    version = bump
    write_new_version version

    version
  end

  protected

  def bump
    old_version = File.read('VERSION').strip!
    new_version = Anvil::Versioner.new(old_version).bump! term

    puts "Bumped from #{old_version} to #{new_version}"

    new_version
  end

  def write_new_version(version)
    file = File.open('VERSION', 'w')
    file.puts version
    file.close
  end
end
