module Abilities
  module ActionView
    module Base
      extend ActiveSupport::Concern

      %w(can? cannot?).each do |name|
        define_method name do |action, subject|
          Abilities.send name, current_user, action, subject
        end
      end

    end
  end
end
