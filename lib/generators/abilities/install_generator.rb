require 'rails/generators'

module Abilities
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def create_capable_concern
      copy_file 'abilities.rb', 'config/abilities.rb'
    end

  end
end
