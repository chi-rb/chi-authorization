module Chi
  module Authorization
    class Railtie < Rails::Railtie

      config.before_initialize do
        load Rails.root.join('config/authorization.rb')
      end

      initializer 'chi.authorization.action_controller' do
        ActiveSupport.on_load :action_controller do
          ActionController::Base.include(
            Authorization::Extensions::ActionController::Base
          )
        end
      end

    end
  end
end
