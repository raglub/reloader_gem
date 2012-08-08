# -*- encoding: utf-8 -*-
require File.expand_path('../lib/reloader_gem/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michal Szyma"]
  gem.email         = ["raglub.ruby@gmail.com"]
  gem.description   = %q{}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.date          = "2012-08-08"
  gem.homepage      = "https://github.com/raglub/reloader_gem"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "reloader_gem"
  gem.require_paths = ["lib"]
  gem.platform      = Gem::Platform::RUBY
  gem.version       = ReloaderGem::VERSION
end
