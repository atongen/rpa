require "rpa/version"
require "pathname"

module Rpa
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

require "rpa/util"
require "rpa/options"
require "rpa/asset"
require "rpa/photos"
require "rpa/page"
require "rpa/runner"
