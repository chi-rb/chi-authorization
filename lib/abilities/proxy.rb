module Abilities
  class Proxy

    def initialize(definitions, &block)
      @definitions = definitions
      instance_eval &block
    end

    def can(actions, resources, &block)
      @definitions.add actions, resources, (block_given? ? block : true)
    end

    def cannot(actions, resources, &block)
      @definitions.add actions, resources, (block_given? ? block : false)
    end

    def method_missing(name, *args, &block)
      @definitions.user.send name, *args, &block
    end

  end
end
