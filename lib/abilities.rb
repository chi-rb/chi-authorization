require 'abilities/action_controller/base'
require 'abilities/action_view/base'
require 'abilities/proxy'
require 'abilities/definitions'
require 'abilities/exceptions'
require 'abilities/concern'
require 'abilities/railtie'

module Abilities
  class << self

    def define(&block)
      @block = block
    end

    def can?(actor, action, subject)
      Definitions.new(actor, &@block).can?(action, subject)
    end

    def cannot?(*args)
      !can?(*args)
    end

  end
end
