module Abilities
  class Definitions

    def initialize(actor, &block)
      @actor = actor
      Proxy.new(actor, self, &block)
    end

    def add(actions, subjects, behavior, &block)
      actions = [actions] unless actions.is_a? Array
      subjects = [subjects] unless subjects.is_a? Array
      subjects.each do |subject|
        actions.each do |action|
          (all[find_subject_id(subject)] ||= {})[action.to_s] = block_given? ? block : behavior
        end
      end
    end

    def can?(action, subject)
      subject_id = find_subject_id(subject)
      if subject_id != 'all' and can?(action, 'all')
        true
      elsif actions = all[subject_id]
        if behavior = (actions[action.to_s] || actions['manage'])
          if behavior.is_a? Proc
            @actor.instance_exec subject, &behavior
          else
            behavior
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

    protected

    def all
      @all ||= {}
    end

    def find_subject_id(subject)
      if subject.to_s == 'all'
        subject.to_s
      elsif subject.is_a? Class
        subject.name
      else
        subject.class.name
      end
    end

  end
end