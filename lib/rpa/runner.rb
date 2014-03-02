require 'fileutils'

module Rpa
  class Runner

    attr_reader :in_dir,
                :out_dir,
                :photos

    def initialize(args)
      @options = Options.new(args).parse!.options

      @in_dir = File.expand_path(@options[:in_dir])
      @photos = Dir["#{in_dir}/**/*"].select do |f|
        %x{ file -ib "#{f}" }.to_s.strip.match(/^image/) && PHOTO_TYPES.any? { |t| f.match(/#{t}$/i) }
      end.sort do |x,y|
        Util.get_file_creation_time(x) <=> Util.get_file_creation_time(y)
      end
      if photos.length == 0
        raise "IN_DIR must contain at least one photo."
      end

      @out_dir = File.expand_path(@options[:out_dir])
      if File.exists?(out_dir)
        unless File.directory?(out_dir)
          raise "OUT_DIR exists and is not a directory."
        end
      end
    end

    def run!
      FileUtils.mkdir_p(out_dir)
      p = Photos.new(out_dir, photos, @options[:verbose])
      Page.new(out_dir, @options[:title], p.photo_map, @options[:verbose])
    end

  end
end
