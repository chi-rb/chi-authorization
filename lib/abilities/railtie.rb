module Abilities
  class Railtie < Rails::Railtie

    initializer :abilites do
      ::ActionController::Base.include(
        Abilities::Extensions::ActionController::Base
      )
      load Rails.root.join('config/abilities.rb')
    end

  end
end
