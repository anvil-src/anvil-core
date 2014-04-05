require 'semantic/version'

module Anvil
  class Versioner < SimpleDelegator
    class NotSupportedTerm < Anvil::Error
      def initialize(term)
        super("Not supported term: #{term}")
      end
    end

    TERMS = [:major, :minor, :patch, :pre, :build]
    attr_reader :version

    def initialize(string)
      version = Semantic::Version.new(string)
      super(version)
    end

    TERMS.each do |term|
      define_method("#{term}!") { bump!(term) }
    end

    # Bumps a version by incrementing one of its terms and reseting the others
    # according to semver specification.
    #
    # @example
    #   Versioner.new('1.2.3-alpha.1+build.2').bump(:major)
    #     # => '2.0.0'
    #   Versioner.new('1.2.3-alpha.1+build.2').bump(:minor)
    #     # => '1.3.0'
    #   Versioner.new('1.2.3-alpha.1+build.2').bump(:patch)
    #     # => '1.2.4'
    #   Versioner.new('1.2.3-alpha.1+build.2').bump(:pre)
    #     # => '1.2.3-alpha.2'
    #   Versioner.new('1.2.3-alpha.1+build.2').bump(:build)
    #     # => '1.2.3-alpha.2+build.3'
    #
    # @param term [Symbol] the term to increment
    # @raise [Anvil::Versioner::NotSuportedTerm] When the given term is invalid
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
      self.minor = 0 if term == :major
      self.patch = 0 if term == :major || term == :minor
      self.pre   = nil if [:major, :minor, :patch].include? term
      self.build = nil if [:major, :minor, :patch, :pre].include? term

      self
    end
  end
end
