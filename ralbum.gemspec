# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ralbum/version'

Gem::Specification.new do |spec|
  spec.name          = "ralbum"
  spec.version       = Ralbum::VERSION
  spec.authors       = ["Andrew Tongen"]
  spec.email         = ["atongen@nerdery.com"]
  spec.summary       = %q{Generate simple html photo albums}
  spec.homepage      = "http://github.com/atongen/ralbum"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "rmagick"
  spec.add_dependency "exifr"
end
