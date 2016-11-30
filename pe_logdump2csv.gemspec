# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pe_logdump2csv/version'

Gem::Specification.new do |spec|
  spec.name          = "pe_logdump2csv"
  spec.version       = PeLogdump2csv::VERSION
  spec.authors       = ["Geoff Williams"]
  spec.email         = ["geoff.williams@puppetlabs.com"]

  spec.summary       = %q{Turn JSON dumps from PE into CSV}
  spec.description   = %q{Parse a directory full of JSON files from puppet and cherry pick keys we are interested in.}
  spec.homepage      = "https://github.com/GeoffWilliams/pe_logdump2csv"
  spec.license       = "Apache 2"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "escort", "0.4.0"
end
