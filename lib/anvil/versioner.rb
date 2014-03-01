require 'semantic/version'

module Anvil
  class Versioner < SimpleDelegator
    class NotSupportedTerm < Anvil::Error
      def initialize(term)
        super("Not supported term: #{term}")
      end
    end

    TERMS = %i[major minor patch pre build]
    attr_reader :version

    def initialize(string)
      version = Semantic::Version.new(string)
      super(version)
    end

    TERMS.each do |term|
      define_method("#{term}!") { bump!(term) }
    end

    def bump!(term)
      fail NotSupportedTerm.new(term) unless TERMS.include?(term.to_sym)

      new_version = clone
      new_value = increment send(term)

      new_version.send("#{term}=", new_value)
      new_version.reset_terms_for(term)
    end

    protected

    def increment(old_value)
      case old_value
      when Fixnum
        old_value + 1
      when String
        components = old_value.split('.')
        components[-1] = components[-1].to_i + 1
        components.join('.')
      end
    end

    # Resets all the terms which need to be reset after a bump
    #
    # @param term [Symbol] The term which has been bumped
    # @return [Anvil::Versioner] A new version with the proper number
    # @todo we still need to reset pre-release and builds properly
    def reset_terms_for(term)
      tap do |ver|
        ver.minor = 0 if term == :major
        ver.patch = 0 if term == :major || term == :minor
        ver.pre   = nil if %i[major minor patch].include? term
        ver.build = nil if %i[major minor patch pre].include? term
      end
    end
  end
end
