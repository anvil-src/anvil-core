module Mixlib::Config
  alias_method :old_method_missing, :method_missing

  # Override Mixlib::Config#method_missing so we can do
  # things like this:
  #
  # @example define a nested group without use config_context
  #
  #  projects do
  #    branch_flow %w[release master]
  #    project-one do
  #      branch_flow %w[integration release master]
  #    end
  #  end
  def method_missing(method, *args, &block)
    if block_given?
      config_context(method, &block)
    else
      old_method_missing(method, *args)
    end
  end
end
