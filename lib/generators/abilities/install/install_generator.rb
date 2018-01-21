require 'rails/generators'

module Abilities
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_initializer_file
        copy_file 'initializer.rb', 'config/initializers/abilities.rb'
      end

      def create_configuration_file
        copy_file 'configuration.rb', 'config/abilities.rb'
      end

    end
  end
end
