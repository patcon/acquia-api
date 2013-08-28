# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acapi/version'

Gem::Specification.new do |spec|
  spec.name          = "acapi"
  spec.version       = Acapi::VERSION
  spec.authors       = ["Patrick Connolly"]
  spec.email         = ["patrick@myplanetdigital.com"]
  spec.description   = %q{Ruby implementation of the Acquia Cloud API.}
  spec.summary       = %q{Ruby implementation of the Acquia Cloud API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
