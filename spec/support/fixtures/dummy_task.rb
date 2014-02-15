class DummyTask < Anvil::Task
  parser do
    on('-a', '--argument [VALUE]') do |val|
      options[:argument] = val
    end
  end

  def initialize(*args)
    @options = args.extract_options!
    @arg1 = args[0]
    @arg2 = args[1]
  end

  def task; end
end
