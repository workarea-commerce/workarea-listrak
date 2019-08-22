$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require "workarea/listrak/version"

Gem::Specification.new do |s|
  s.name        = "workarea-listrak"
  s.version     = Workarea::Listrak::VERSION
  s.authors     = ["Eric Pigeon"]
  s.email       = ["epigeon@workarea.com"]
  s.homepage    = "https://github.com/workarea-commerce/workarea-listrak"
  s.summary     = "Listrak plugin for Workarea"
  s.description = "Integrates with Listrak services"
  s.files       = `git ls-files`.split("\n")
  s.license = 'Business Software License'

  s.add_dependency "workarea", "~> 3.x", ">= 3.0.5"
end
