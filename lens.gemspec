# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lens/version'

Gem::Specification.new do |spec|
  spec.name          = "lens"
  spec.version       = Lens::VERSION
  spec.authors       = ["kgorin", "artygus", "zzet"]
  spec.email         = ["me@kgor.in", "artygus@engineeram.net", "me@zzet.org"]
  spec.summary       = %q{Gem to send Rails request stats}
  spec.homepage      = "https://github.com/lenshq/lens_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'bson', "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"   , '~> 0'
  spec.add_development_dependency 'rspec'  , '~> 3.2'
  spec.add_development_dependency "pry"    , '~> 0.10'
  spec.add_development_dependency "pry-nav", '~> 0'
  spec.add_development_dependency "tty"    , '~> 0'
end
