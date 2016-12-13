module Abilities
  class Railtie < Rails::Railtie

    config.before_initialize do
      load Rails.root.join('config/abilities.rb')
    end

    initializer 'abilites.action_controller' do
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.include(
          Abilities::Extensions::ActionController::Base
        )
      end
    end

  end
end
