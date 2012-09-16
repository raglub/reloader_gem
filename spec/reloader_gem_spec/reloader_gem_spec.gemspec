# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reloader_gem_spec/version'

Gem::Specification.new do |gem|
  gem.name          = "reloader_gem_spec"
  gem.version       = ReloaderGemSpec::VERSION
  gem.authors       = ["michal szyma"]
  gem.email         = ["raglub.ruby@gmail.com"]
  gem.description   = %q{Internal gem only for testing}
  gem.summary       = %q{Internal gem only for testing}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
end
