require 'semantic/version'

module Anvil
  class Versioner < SimpleDelegator
    class NotSupportedTerm < StandardError
      def initialize(term)
        super("Not supported term: #{term}")
      end
    end

    TERMS = %i[major minor patch]
    attr_reader :version

    def initialize(string)
      version = Semantic::Version.new(string)
      super(version)
    end

    TERMS.each do |term|
      define_method("#{term}!") { increment!(term) }
    end

    def increment!(term)
      fail NotSupportedTerm.new(term) unless TERMS.include?(term.to_sym)

      new_version = clone
      new_value = send(term) + 1

      new_version.send("#{term}=", new_value)
      new_version.minor = 0 if term == :major
      new_version.patch = 0 if term == :major || term == :minor
      new_version.build = new_version.pre = nil

      new_version
    end
  end
end
