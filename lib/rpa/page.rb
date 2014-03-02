module Rpa
  class Page

    def initialize(dir, title, photo_map, verbose = false)
      @dir = dir
      @title = title
      @photo_map = photo_map
      @verbose = verbose
      asset = Asset.new
      puts "Writing index.html" if verbose?
      File.open(File.join(@dir, "index.html"), "w") { |f| f << asset.html(@dir, @title, @photo_map) }

      puts "Writing app.css" if verbose?
      File.open(File.join(@dir, "app.css"), "w") { |f| f << asset.css }

      puts "Writing app.js" if verbose?
      File.open(File.join(@dir, "app.js"), "w") { |f| f << asset.js }
    end

    private

    def verbose?
      !!@verbose
    end
  end
end
