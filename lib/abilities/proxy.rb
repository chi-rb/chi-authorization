module Abilities
  class Proxy

    def initialize(actor, definitions, &block)
      @actor = actor
      @definitions = definitions
      instance_eval &block
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
