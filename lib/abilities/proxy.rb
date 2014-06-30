module Abilities
  class Proxy

    def initialize(actor, &block)
      @actor = actor
      @block = block
      @definitions = Definitions.new
    end

    def load
      instance_eval &@block
      @definitions.all
    end

    def can(actions, subjects, &block)
      @definitions.add actions, subjects, true, &block
    end

    def cannot(actions, subjects, &block)
      @definitions.add actions, subjects, false, &block
    end

    def method_missing(name, *args, &block)
      @actor.send name, *args, &block
    end

  end
end
