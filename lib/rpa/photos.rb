require 'RMagick'
require 'fileutils'

class Photos
  include Magick

  PREVIEW_SIZE = 500
  THUMB_SIZE = 75

  attr_reader :photo_map

  def initialize(photos = [], options = {})
    @dir = options[:out_dir]
    @photo_map = photos.inject({}) do |photo_map,p|
      file_name = File.basename(p)
      while photo_map.has_key?(file_name)
        ext = File.extname(file_name)
        basename = File.basename(file_name, ext)
        if m = basename.match(/(.*)\-([\d]+)$/)
          file_name = "#{m[1]}-#{m[2].to_i+1}#{ext}"
        else
          file_name = "#{basename}-1#{ext}"
        end
      end
      photo_map[file_name] = p
      photo_map
    end
    @verbose = options[:verbose]

    setup_dirs
    write
    fix_orientation
  end

  def original_dir
    @original_dir ||= File.join(@dir, "images", "original")
  end

  def preview_dir
    @preview_dir ||= File.join(@dir, "images", "preview")
  end

  def thumb_dir
    @thumb_dir ||= File.join(@dir, "images", "thumb")
  end

  private

  def verbose?
    !!@verbose
  end

  def load_image(path)
    ri = ImageList.new(path)
    if path.match(/(jpg|jpeg)$/i)
      # fix orientation from exif data
      case ri.orientation.to_i
      when 2
        ri.flop!
      when 3
        ri.rotate!(180)
      when 4
        ri.flip!
      when 5
        ri.transpose!
      when 6
        ri.rotate!(90)
      when 7
        ri.transverse!
      when 8
        ri.rotate!(270)
      end
    end
    ri
  end

  def setup_dirs
    if File.directory?(original_dir)
      puts "Removing existing original image directory" if verbose?
      FileUtils.rm_rf(original_dir)
    end
    FileUtils.mkdir_p(original_dir)

    if File.directory?(preview_dir)
      puts "Removing existing preview image directory" if verbose?
      FileUtils.rm_rf(preview_dir)
    end
    FileUtils.mkdir_p(preview_dir)

    if File.directory?(thumb_dir)
      puts "Removing existing thumb image directory" if verbose?
      FileUtils.rm_rf(thumb_dir)
    end
    FileUtils.mkdir_p(thumb_dir)
  end

  def write
    @photo_map.each do |name,path|
      puts "Writing original #{name}" if verbose?
      ri = load_image(path)
      ri.write(File.join(original_dir, name))

      puts "Writing preview #{name}" if verbose?
      ri.resize_to_fit!(PREVIEW_SIZE)
      ri.write(File.join(preview_dir, name))

      puts "Writing thumb #{name}" if verbose?
      ri.resize_to_fill!(THUMB_SIZE)
      ri.write(File.join(thumb_dir, name))

      ri.destroy!
    end
  end

  def fix_orientation
    jpegs = @photo_map.keys.select { |p| p.match(/(jpg|jpeg)$/i) }.map do |r|
      [original_dir, preview_dir, thumb_dir].map do |d|
        "\"#{File.join(d, r)}\""
      end
    end.flatten.compact.join(' ')
    unless jpegs == ""
      puts "Removing EXIF orientation" if verbose?
      %x{ jhead -norot #{jpegs} }
    end
  end
end
