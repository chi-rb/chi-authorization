$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'abilities/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'abilities'
  s.version     = Abilities::VERSION
  s.authors     = ['mmontossi']
  s.email       = ['mmontossi@museways.com']
  s.homepage    = 'https://github.com/mmontossi/abilities'
  s.summary     = 'Abilities for rails.'
  s.description = 'Authorization dsl to manage permissions in rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.0'

  s.add_development_dependency 'pg', '~> 0.21.0'
end
