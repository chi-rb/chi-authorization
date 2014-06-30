module Abilities
  class Railtie < Rails::Railtie

    initializer 'abilites' do
      ::ActionView::Base.send :include, Abilities::ActionView::Base
      ::ActionController::Base.send :include, Abilities::ActionController::Base
    end

  end
end
