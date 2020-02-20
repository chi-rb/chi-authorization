require_relative 'boot'
require 'rails/all'

Bundler.require *Rails.groups
require 'chi/authorization'

class Application < Rails::Application
end
