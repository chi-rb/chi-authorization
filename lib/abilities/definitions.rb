module Abilities
  class Definitions

    def all
      @all ||= {}
    end

    def add(actions, models, behavior, &block)
      actions = [actions] unless actions.is_a? Array
      models = [models] unless models.is_a? Array
      models.map(&:name).each do |model|
        all[model] = {} unless all[model]
        actions.each do |action|
          all[model][action] = block_given? ? block : behavior
        end
      end
    end

  end
end
