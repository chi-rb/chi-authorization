module Abilities
  module ActionController
    module Base
      extend ActiveSupport::Concern

      protected

      %w(can? cannot?).each do |name|
        define_method name do |action, subject|
          Abilities.send name, current_user, action, subject
        end
      end

      def authorize!(action, subject)
        raise Abilities::AccessDenied unless can? action, subject
      end

    end
  end
end
