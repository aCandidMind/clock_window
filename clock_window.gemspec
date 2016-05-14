# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clock_window/version'

Gem::Specification.new do |spec|
  spec.name          = "clock_window"
  spec.version       = ClockWindow::VERSION
  spec.authors       = ["Daniel P. Clark"]
  spec.email         = ["6ftdan@gmail.com"]

  spec.summary       = %q{Record current active window.}
  spec.description   = %q{Clock active window.  Time tracker by window name.}
  spec.homepage      = "https://github.com/danielpclark/clock_window"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(assets|test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "neatjson", "~> 0.8"
  spec.add_dependency "slop", "~> 4.3"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.1"
  spec.add_development_dependency "minitest", "~> 5.8"
end
