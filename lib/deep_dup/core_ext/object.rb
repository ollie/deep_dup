module DeepDup
  # This module holds extensions for core classes.
  module CoreExt
    # Extension for +Object+ class.
    module Object
      # Deep duplicate any object by delegating to +DeepDup.deep_dup+.
      #
      # @example
      #   require 'deep_dup/core_ext/object'
      #
      #   dupped = 'chunky'.deep_dup
      #   dupped = ['chunky', [:bacon, { hi: 5 }]].deep_dup
      #   dupped = ['a', :a, 1, { bacon: { chunky: 'yeah' } }].deep_dup
      #   dupped = SomeClass.new.deep_dup
      #
      # @return [Object] Dupped object if possible.
      def deep_dup
        DeepDup.deep_dup(self)
      end
    end
  end
end

# Add +Object#deep_dup+.
Object.send(:include, DeepDup::CoreExt::Object)
