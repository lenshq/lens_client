# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lens/version'

Gem::Specification.new do |spec|
  spec.name          = 'lens'
  spec.version       = Lens::VERSION
  spec.authors       = %w(zzet kgorin artygus)
  spec.email         = ['me@zzet.org', 'me@kgor.in', 'artygus@engineeram.net']
  spec.summary       = 'Gem to send Rails request stats'
  spec.homepage      = 'https://github.com/lenshq/lens_client'
  spec.license       = 'MIT'

  files = `git ls-files -z`.split("\x0")
  files &= (
    Dir['lib/**/*.{rb,pem}'] +
    Dir['ext/**/*.{h,c,rb}'] +
    Dir['*.md'])

  spec.files = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.extensions << 'ext/lens_memprof/extconf.rb'

  spec.add_runtime_dependency 'lz4-ruby'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rails', '>= 3.0'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'pry-nav', '~> 0'
  spec.add_development_dependency 'rake-compiler'
end
