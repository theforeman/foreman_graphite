$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'foreman_graphite/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'foreman_graphite'
  s.version     = ForemanGraphite::VERSION
  s.authors     = ['Ohad Levy']
  s.email       = ['ohadlevy@gmail.com']
  s.homepage    = 'http://theforeman.org'
  s.summary     = 'Adds graphite integration to foreman'
  s.description = 'adds graphite support to foreman'
  s.licenses    = ['GPL-3']

  s.files = Dir['{app,config,db,lib}/**/*'] + %w(LICENSE Rakefile README.md foreman_graphite.yaml.example)
  s.test_files = Dir['test/**/*']

  s.add_dependency 'graphite-api'
end
