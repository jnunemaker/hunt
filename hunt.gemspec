# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hunt/version"

Gem::Specification.new do |s|
  s.name        = "hunt"
  s.version     = Hunt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Nunemaker"]
  s.email       = ["nunemaker@gmail.com"]
  s.homepage    = "http://github.com/jnunemaker/hunt"
  s.summary     = %q{Really basic search for MongoMapper models.}
  s.description = %q{Really basic search for MongoMapper models.}

  s.add_dependency 'fast-stemmer', '~> 1.0'
  s.add_dependency 'mongo_mapper',  '~> 0.9.0'

  s.add_development_dependency 'rspec', '~> 2.3'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
