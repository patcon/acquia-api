# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acapi/version'

Gem::Specification.new do |spec|
  spec.name          = "acapi"
  spec.version       = AcquiaCloudApi::VERSION
  spec.authors       = ["Sam Boyer", "Patrick Connolly"]
  spec.email         = ["tech@samboyer.org", "patrick@myplanetdigital.com"]
  spec.description   = %q{Ruby implementation of the Acquia Cloud API.}
  spec.summary       = %q{Ruby implementation of the Acquia Cloud API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
