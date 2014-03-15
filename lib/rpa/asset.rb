require 'erb'

module Rpa
  class Asset

    def initialize(photo_map, options = {})
      @photo_map = photo_map
      @options = options
    end

    def html
      photo_map = @photo_map
      options = @options
      build('app.html.erb', binding)
    end

    def js
      path('app.js')
    end

    def css
      path('app.css')
    end

    private

    def path(file)
      Rpa.root.join('templates', @options[:theme], file)
    end

    def build(file, local_binding)
      ERB.new(File.read(path(file))).result(local_binding)
    end
  end
end
