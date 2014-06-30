require 'abilities/action_controller/base'
require 'abilities/action_view/base'
require 'abilities/definitions'
require 'abilities/exceptions'
require 'abilities/capable'
require 'abilities/proxy'
require 'abilities/railtie'

module Abilities
  class << self

    def define(&block)
      @block = block
    end

    def can?(actor, action, subject)
      if definitions = find(actor)
        if actions = definitions[find_class_name(subject)]
          if behavior = actions[action]
            if behavior.is_a? Proc
              actor.instance_exec subject, &behavior
            else
              behavior
            end
          else
            false
          end
        else
          false
        end
      else
        false
      end
    end

    def cannot?(*args)
      !can? *args
    end

    protected

    def find_class_name(subject)
      if subject.is_a? Class
        subject.name
      else
        subject.class.name
      end
    end

    def cache 
      @cache ||= {}
    end

    def find(actor)
      cache[actor.class.name] = Proxy.new(actor, &@block).load
    end

  end
end
