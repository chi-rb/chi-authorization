module Abilities
  module Capable
    extend ActiveSupport::Concern

    %w(can? cannot?).each do |name|
      define_method name do |action, subject|
        Abilities.send name, self, action, subject
      end
    end

  end
end
