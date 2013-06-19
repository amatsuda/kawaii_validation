# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "kawaii_validation"
  spec.version       = '0.0.1'
  spec.authors       = ["Akira Matsuda"]
  spec.email         = ["ronnie@dio.jp"]
  spec.description   = 'Model.validates { presence_of :name }'
  spec.summary       = 'An ActiveRecord extension that adds more kawaii validation syntax'
  spec.homepage      = 'https://github.com/amatsuda/kawaii_validation'
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'railties'
  spec.add_dependency 'activerecord'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
end
