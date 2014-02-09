class DummyTask < Alfred::Task

  def initialize(*args)
    @options = args.extract_options!
    @arg1 = args[0]
    @arg2 = args[1]
  end

  def task; end

  def self.parse_options(arguments)
    options = {}

    OptionParser.new do |opts|
      opts.on('-a', '--argument [VALUE]') do |val|
        options[:argument] = val
      end.parse! arguments
    end

    arguments << options
    arguments
  end
end
