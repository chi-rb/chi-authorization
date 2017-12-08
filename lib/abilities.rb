require 'abilities/extensions/action_controller/base'
require 'abilities/configuration'
require 'abilities/definitions'
require 'abilities/exceptions'
require 'abilities/proxy'
require 'abilities/railtie'
require 'abilities/version'

module Abilities
  class << self

    attr_reader :block

    def configuration
      @configuration ||= Configuration.new
    end

    def define(&block)
      @block = block
    end

    def configure
      yield configuration
    end

    %i(can? cannot?).each do |name|
      define_method name do |user, action, resource|
        definitions = Definitions.new(user, &block)
        definitions.send name, action, resource
      end
    end

  end
end
