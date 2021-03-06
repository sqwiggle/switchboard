# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'switchboard/version'

Gem::Specification.new do |spec|
  spec.name          = "sqwiggle-switchboard"
  spec.version       = Switchboard::VERSION
  spec.authors       = ["Luke Roberts"]
  spec.email         = ["luke@sqwiggle.com"]
  spec.summary       = %q{Define groups of behaviours in an abstracted location for notifying external services}
  spec.description   = %q{Define groups of behaviours in an abstracted location for notifying external services}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
