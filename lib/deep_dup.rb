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
  #
  # @return [Object] Dupped object if possible.
  def self.deep_dup(object) # rubocop:disable Metrics/MethodLength
    case object
    when String
      object.dup
    when nil, false, true, Numeric, Symbol, Method
      object
    when Array
      object.map { |item| deep_dup(item) }
    when Hash
      object.each.with_object({}) do |(key, value), hash|
        hash[deep_dup(key)] = deep_dup(value)
      end
    else # Object, Class
      object.dup
    end
  end
end
