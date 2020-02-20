$:.push File.expand_path('../lib', __FILE__)

require 'chi/authorization/version'

Gem::Specification.new do |s|
  s.name        = 'chi-authorization'
  s.version     = Chi::Authorization::VERSION
  s.authors     = ['mmontossi']
  s.email       = ['hi@chi-rb.org']
  s.homepage    = 'https://github.com/chi-rb/chi-authorization'
  s.summary     = 'Authorization for Rails.'
  s.description = 'DSL to manage user permissions in Rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2'

  s.add_development_dependency 'pg'
end
