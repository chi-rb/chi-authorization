module Chi
  module Authorization
    module Extensions
      module ActionController
        module Base
          extend ActiveSupport::Concern

          included do
            helper_method :can?, :cannot?
          end

          %w(can? cannot?).each do |name|
            define_method name do |action, resource|
              user = send(Authorization.configuration.helper_name)
              Authorization.send name, user, action, resource
            end
          end

          private

          def authorize!(action, subject)
            if cannot?(action, subject)
              raise Exceptions::AccessDenied
            end
          end

        end
      end
    end
  end
end
