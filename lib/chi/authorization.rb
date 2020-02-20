require 'chi/authorization/extensions/action_controller'
require 'chi/authorization/configuration'
require 'chi/authorization/policies'
require 'chi/authorization/exceptions'
require 'chi/authorization/proxy'
require 'chi/authorization/railtie'
require 'chi/authorization/version'

module Chi
  module Authorization
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
          policies = Policies.new(user, &block)
          policies.send name, action, resource
        end
      end

    end
  end
end
