module Chi
  module Authorization
    class Proxy

      def initialize(policies, options={}, parent_scope=nil, &block)
        @scope = merge_scopes(options, parent_scope)
        @policies = policies
        instance_exec policies.user, &block
      end

      def can(actions, resources, options={})
        @policies.add actions, resources do |record|
          if inner_scope = build_scope(options)
            @scope.call && inner_scope.call(record)
          else
            true
          end
        end
      end

      def cannot(actions, resources, options={})
        @policies.add actions, resources do |record|
          if inner_scope = build_scope(options)
            @scope.call && !inner_scope.call(record)
          else
            false
          end
        end
      end

      def scope(options={}, &block)
        Proxy.new @policies, options, @scope, &block
      end

      private

      def merge_scopes(options, parent_scope)
        self_scope = build_scope(options)
        -> {
          fallback_scope(parent_scope) &&
          fallback_scope(self_scope)
        }
      end

      def fallback_scope(scope)
        scope ? scope.call : true
      end

      def build_scope(options)
        if block = options[:if]
          ->(*args) { block.call *args }
        elsif block = options[:unless]
          ->(*args) { !block.call *args }
        end
      end

    end
  end
end
