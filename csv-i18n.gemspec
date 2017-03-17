# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_i18n/version'

Gem::Specification.new do |spec|
  spec.name          = "csv-i18n"
  spec.version       = CSVI18n::VERSION
  spec.authors       = ["Jeremy Baker"]
  spec.email         = ["jhubert@gmail.com"]

  spec.summary       = %q{Support translation of CSV parsing errors via I18n}
  spec.homepage      = "https://github.com/jhubert/csv-i18n"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
