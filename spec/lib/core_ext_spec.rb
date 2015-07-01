require 'spec_helper'

require 'deep_dup/core_ext/object'

describe 'Object#deep_dup' do
  it 'string' do
    original = 'a'
    dupped   = original.deep_dup

    expect(original.object_id).to_not eq(dupped.object_id)
  end
end
