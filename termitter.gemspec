# -*- encoding: utf-8 -*-
$:.push File.expand_path("../src", __FILE__)
require "termitter"

Gem::Specification.new do |s|
  s.name        = "termitter"
  s.version     = Termitter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Pavlo Kerestey"]
  s.email       = ["pavlo@kerestey.net"]
  s.homepage    = "http://rubygems.org/gems/termitter"
  s.summary     = %q{A simple terminal twitter client which prints the home timeline.}
  s.description = %q{A terminal read-only twitter client. It prints the tweets along with the nicknames to the terminal output.}

  s.rubyforge_project = "termitter"

  s.add_dependency "twitter_oauth"

  s.add_development_dependency "bundler", "~> 1.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {tests,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["src"]

  s.has_rdoc = false
end
