$:.unshift File.expand_path('../lib', __FILE__)
require 'ranglia'

spec = Gem::Specification.new do |s|
  s.name        = "ranglia"
  s.version     = Ranglia::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Simple ruby toolbox for Ganglia"
  s.description = s.summary
  s.author      = "Gilles Devaux"
  s.email       = "gilles.devaux@gmail.com"
  s.homepage    = "http://girhub.com/gilles/ranglia"

  s.add_dependency 'gmetric'
  s.add_dependency 'daemons'

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  
  s.bindir      = "bin"
  s.executables = %w(ranglia)

  s.require_path = 'lib'
  s.files        = %w(LICENSE README.rdoc Rakefile) + Dir.glob("{docs,lib,spec}/**/*")
end