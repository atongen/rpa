require "ralbum/version"
require "pathname"

module Ralbum
  PHOTO_TYPES = %w{ jpg jpeg png gif tiff tif bmp }

  def self.check_system
    if %x{ which jhead }.to_s.strip == ""
      STDERR.puts "This program requires the jhead binary to be found in PATH"
      exit 1
    end
  end

  def self.root
    @root ||= Pathname.new(File.expand_path('../..', __FILE__))
  end

end

require "ralbum/util"
require "ralbum/options"
require "ralbum/asset"
require "ralbum/photos"
require "ralbum/page"
require "ralbum/runner"
