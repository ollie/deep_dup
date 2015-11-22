# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deep_dup/version'

Gem::Specification.new do |spec|
  spec.name          = 'deep_dup'
  spec.version       = DeepDup::VERSION
  spec.authors       = ['Oldrich Vetesnik']
  spec.email         = ['oldrich.vetesnik@gmail.com']

  spec.summary       = 'Deep duplicate Ruby objects.'
  spec.homepage      = 'https://github.com/ollie/deep_dup'
  spec.license       = 'MIT'

  # rubocop:disable Metrics/LineLength
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # System
  spec.add_development_dependency 'bundler', '~> 1.10'

  # Test
  spec.add_development_dependency 'rspec',     '~> 3.4'
  spec.add_development_dependency 'simplecov', '~> 0.10'

  # Code style, debugging, docs
  spec.add_development_dependency 'rubocop', '~> 0.35'
  spec.add_development_dependency 'pry',     '~> 0.10'
  spec.add_development_dependency 'yard',    '~> 0.8'
  spec.add_development_dependency 'rake',    '~> 10.4'
end
