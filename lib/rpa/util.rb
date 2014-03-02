require 'exifr'

module Rpa
  module Util
    extend self

    def get_file_creation_time(path)
      ext = File.extname(path)
      t = if m = ext.downcase.match(/(tiff|tif|jpg|jpeg)$/)
        exif_class = m[1][0] == 't' ? EXIFR::TIFF : EXIFR::JPEG
        begin
          exif = exif_class.new(path)
          exif.date_time ||
            exif.date_time_original ||
            exif.date_time_digitized
        rescue => e
          STDERR.puts "Error getting EXIF data for #{path}: #{e.message}"
        end
      end
      t ||= File::Stat.new(path).ctime
    end

  end
end
