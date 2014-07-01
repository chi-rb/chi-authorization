module Abilities
  class Railtie < Rails::Railtie

    initializer 'abilites' do
      User rescue {}
      if defined? User
        User.send :include, Abilities::Concern
      end
      ::ActionView::Base.send :include, Abilities::ActionView::Base
      ::ActionController::Base.send :include, Abilities::ActionController::Base
    end

  end
end
