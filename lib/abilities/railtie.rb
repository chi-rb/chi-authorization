module Abilities
  class Railtie < Rails::Railtie

    initializer 'abilites.extensions' do
      ::ActionController::Base.include(
        Abilities::Extensions::ActionController::Base
      )
    end

    config.after_initialize do
      load Rails.root.join('config/abilities.rb')
    end

  end
end
