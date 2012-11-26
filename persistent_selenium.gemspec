# -*- encoding: utf-8 -*-
require File.expand_path('../lib/persistent_selenium/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Keep your Selenium browser open while you use Capybara to talk to it. Save seconds and sanity.}
  gem.summary       = %q{Keep your Selenium browser open while you use Capybara to talk to it. Save seconds and sanity.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "persistent_selenium"
  gem.require_paths = ["lib"]
  gem.version       = PersistentSelenium::VERSION
end
