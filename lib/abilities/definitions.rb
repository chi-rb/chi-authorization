module Abilities
  class Definitions

    attr_reader :user

    def initialize(user, &block)
      @user = user
      Proxy.new self, &block
    end

    def can?(action, resource)
      id = normalize_id(resource)
      if id != :any && can?(action, :any)
        true
      elsif actions = registry[id]
        if policy = (actions[action] || actions[:manage])
          if policy.is_a?(Proc)
            user.instance_exec resource, &policy
          else
            policy
          end
        else
          false
        end
      else
        false
      end
    end

    def cannot?(*args)
      !can?(*args)
    end

    def add(actions, resources, policy)
      unless actions.is_a?(Array)
        actions = [actions]
      end
      unless resources.is_a?(Array)
        resources = [resources]
      end
      resources.each do |resource|
        actions.each do |action|
          id = normalize_id(resource)
          registry[id] ||= {}
          registry[id][action] = policy
        end
      end
    end

    private

    def registry
      @registry ||= {}
    end

    def normalize_id(resource)
      case resource
      when :any
        resource
      when Class
        resource.name.underscore.to_sym
      else
        resource.class.name.underscore.to_sym
      end
    end

  end
end
