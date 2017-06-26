require 'abilities/extensions/action_controller/base'
require 'abilities/definitions'
require 'abilities/exceptions'
require 'abilities/proxy'
require 'abilities/railtie'
require 'abilities/version'

module Abilities
  class << self

    attr_reader :block

    def define(&block)
      @block = block
    end

    %i(can? cannot?).each do |name|
      define_method name do |user, action, resource|
        Definitions.new(user, &block).send name, action, resource
      end
    end

  end
end
