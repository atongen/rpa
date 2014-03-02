require 'erb'

module Rpa
  class Asset

    def initialize(*o)
      @options = *o.pop if o.last.is_a?(Hash)
    end

    def html(dir, title, photo_map)
      build('app.html.erb', binding)
    end

    def js
      build('app.js.erb', binding)
    end

    def css
      build('app.css.erb', binding)
    end

    private

    def build(template, local_binding)
      ERB.new(File.read(Rpa.root.join('templates', template))).result(local_binding)
    end
  end
end
