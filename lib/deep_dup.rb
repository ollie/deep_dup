require 'deep_dup/version'

# Deep duplicate any object. Some objects cannot be +dup+ped like +nil+,
# +false+, +true+, numbers, symbols and method objects. In those cases
# return themselvese.
#
# @example No monkey patching
#   dupped = DeepDup.deep_dup('chunky')
#   dupped = DeepDup.deep_dup(['chunky', [:bacon, { hi: 5 }]])
#   dupped = DeepDup.deep_dup(['a', :a, 1, { bacon: { chunky: 'yeah' } }])
#   dupped = DeepDup.deep_dup(SomeClass.new)
#
# @example With monkey patching
#   require 'deep_dup/core_ext/object'
#
#   dupped = 'chunky'.deep_dup
#   dupped = ['chunky', [:bacon, { hi: 5 }]].deep_dup
#   dupped = ['a', :a, 1, { bacon: { chunky: 'yeah' } }].deep_dup
#   dupped = SomeClass.new.deep_dup
module DeepDup
  # Deep duplicate any object.
  #
  # @example
  #   dupped = DeepDup.deep_dup('chunky')
  #   dupped = DeepDup.deep_dup(['chunky', [:bacon, { hi: 5 }]])
  #   dupped = DeepDup.deep_dup(['a', :a, 1, { bacon: { chunky: 'yeah' } }])
  #   dupped = DeepDup.deep_dup(SomeClass.new)
  #
  # @param object [Object] Pretty much anything.
  # @param cache  [Hash]   Cache +object_id+s to prevent stack overflow on
  #                        recursive data structures.
  #
  # @return [Object] Dupped object if possible.
  def self.deep_dup(object, cache = {}) # rubocop:disable Metrics/MethodLength
    case object
    when String
      object.dup
    when nil, false, true, Numeric, Symbol, Method
      object
    when Array
      cache_object(object, [], cache) do |new_object|
        object.each do |item|
          new_object << deep_dup(item, cache)
        end
      end
    when Hash
      cache_object(object, {}, cache) do |new_object|
        object.each do |key, value|
          new_object[deep_dup(key, cache)] = deep_dup(value, cache)
        end
      end
    else # Object, Class
      object.dup
    end
  end

  # Prevent infinite recursion on recursive data structures.
  #
  # Imagine an array that has only one item which is a reference to itself.
  # When entering this method, the cache is empty so we create a new array
  # and map the original object's id to this newly created object.
  #
  # We then give control back to +deep_dup+ so that it can go on and do the
  # adding, which will call itself with the same array and enter this method
  # again.
  #
  # But this time, since the object is the same, we know the duplicate object
  # because we stored in in our little cache. So just go ahead and return it
  # otherwise it would result in an infinite recursion.
  #
  # @param object     [Array, Hash] Original object reference.
  # @param new_object [Array, Hash] The dupped object reference.
  # @param cache      [Hash]        Map from original object_id to dupped object.
  #
  # @yieldparam new_object [Array, Hash] The dupped object reference.
  #
  # @return [Array, Hash] The dupped object.
  def self.cache_object(object, new_object, cache)
    object_id     = object.object_id
    dupped_object = cache[object_id]      # Did we already visit this object?

    return dupped_object if dupped_object # Yes, return it, prevent overflow.

    cache[object_id] = new_object         # Map the original object id to the new object.
    yield(new_object)                     # Let +deep_dup+ do the job.
    new_object                            # Just return it to +deep_dup+.
  end
end
