require 'optparse'

module Rpa
  class Options

    attr_reader :args,
                :options

    def initialize(args)
      @args = args.dup
      # set the default options
      @options = {
        :in_dir => File.expand_path('.'),
        :verbose => false,
        :title => "Ruby Photo Album",
        :theme => "galleriffic",
        :list_themes => false
      }
    end

    def parse!
      OptionParser.new do |opts|
        opts.banner = "Usage: $ rpa [options]\n\n" +
          "rpa is Ruby Photo Album (Generator)\n\n" +
          "Default values:\n" + @options.map {|v| "\t#{v[0]} = #{v[1]}" }.join("\n") + "\n\nOptions:"

        # required arguments

        opts.on("-o", "--out-dir [OUT_DIR]") do |arg|
          @options[:out_dir] = arg
        end

        # optional arguments

        opts.on("-i", "--in-dir [IN_DIR]") do |arg|
          @options[:in_dir] = arg
        end

        opts.on("-v", "--[no-]verbose") do |arg|
          @options[:verbose] = arg
        end

        opts.on("-t", "--title [TITLE]") do |arg|
          @options[:title] = arg
        end

        opts.on("-s", "--subtitle [SUBTITLE]") do |arg|
          @options[:subtitle] = arg
        end

        opts.on("--theme [THEME]") do |arg|
          @options[:theme] = arg
        end

        opts.on("-l", "--[no-]list", "list themes") do |arg|
          @options[:list_themes] = arg
        end

        opts.on_tail("--help") do
          puts opts
          exit 0
        end
      end.parse!(args)
      validate!
      self
    end

    def validate!
      # validate options
      if @options[:in_dir].to_s.strip == "" ||
        !File.directory?(@options[:in_dir])
        raise "IN_DIR is required."
      end
    end

  end
end
