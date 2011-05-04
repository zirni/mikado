# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mikado/version"

Gem::Specification.new do |s|
  s.name        = "mikado"
  s.version     = Mikado::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matthias Zirnstein"]
  s.email       = ["matthias.zirnstein+mikado@gmail.com"]
  s.homepage    = "https://github.com/zirni/mikado"
  s.summary     = %q{Wrap validation conditions with a single command}
  s.description = %q{}

  s.rubyforge_project = "mikado"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
