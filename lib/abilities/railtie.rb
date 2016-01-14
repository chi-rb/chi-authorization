module Abilities
  class Railtie < Rails::Railtie

    initializer 'abilites' do
      ::ActionView::Base.send :include, Abilities::ActionView::Base
      ::ActionController::Base.send :include, Abilities::ActionController::Base
    end

    config.after_initialize do
      load Rails.root.join('config/abilities.rb')
    end

  end
end