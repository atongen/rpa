require 'fileutils'

module Rpa
  class Page

    attr_reader :options

    def initialize(photo_map, options = {})
      @options = options
      asset = Asset.new(photo_map, @options)

      puts "Writing index.html" if verbose?
      File.open(path("index.html"), "w") { |f| f << asset.html }

      puts "Writing app.css" if verbose?
      FileUtils.cp(asset.css, path('app.css'))

      puts "Writing app.js" if verbose?
      FileUtils.cp(asset.js, path('app.js'))
    end

    private

    def verbose?
      !!options[:verbose]
    end

    def path(file)
      File.join(options[:out_dir], file)
    end
  end
end
