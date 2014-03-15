require 'fileutils'

module Rpa
  class Runner

    attr_reader :options,
                :photos

    def initialize(args)
      @options = Options.new(args).parse!.options

      if @options[:list_themes]
        puts Rpa.themes.join("\n")
        exit 0
      end

      options[:in_dir] = File.expand_path(options[:in_dir])
      @photos = Dir["#{options[:in_dir]}/**/*"].select do |f|
        %x{ file -ib "#{f}" }.to_s.strip.match(/^image/) && PHOTO_TYPES.any? { |t| f.match(/#{t}$/i) }
      end.sort do |x,y|
        Util.get_file_creation_time(x) <=> Util.get_file_creation_time(y)
      end

      if photos.length == 0
        raise "IN_DIR must contain at least one photo."
      end

      options[:out_dir] = File.expand_path(options[:out_dir])
      if File.exists?(options[:out_dir])
        unless File.directory?(options[:out_dir])
          raise "OUT_DIR exists and is not a directory."
        end
      end
    end

    def run!
      FileUtils.mkdir_p(options[:out_dir]) unless File.directory?(options[:out_dir])
      p = Photos.new(photos, options)
      Page.new(p.photo_map, options)
    end

  end
end
