require 'spec_helper'

describe 'DeepDup.deep_dup' do
  it 'String' do
    original = 'a'
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to_not eq(dupped.object_id)
  end

  it 'Numeric (not duppable)' do
    original = 1
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to eq(dupped.object_id)
  end

  it 'Object' do
    klass = Class.new
    original = klass.new
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to_not eq(dupped.object_id)
  end

  it 'Class' do
    original = Class.new
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to_not eq(dupped.object_id)
  end

  it 'NilClass (not duppable)' do
    original = nil
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to eq(dupped.object_id)
  end

  it 'FalseClass (not duppable)' do
    original = false
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to eq(dupped.object_id)
  end

  it 'TrueClass (not duppable)' do
    original = true
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to eq(dupped.object_id)
  end

  it 'Symbol (not duppable)' do
    original = :some_key
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to eq(dupped.object_id)
  end

  it 'BigDecimal (not duppable)' do
    original = BigDecimal.new('1.0')
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to eq(dupped.object_id)
  end

  it 'Method (not duppable)' do
    original = method(:puts)
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to eq(dupped.object_id)
  end

  it 'Array' do
    original = %w(a b)
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to_not eq(dupped.object_id)
  end

  it 'Hash' do
    original = { chunky: 'Bacon!' }
    dupped   = DeepDup.deep_dup(original)

    expect(original.object_id).to_not eq(dupped.object_id)
  end

  context 'Array of strings' do
    let(:original) { %w(a b) }
    let(:dupped)   { DeepDup.deep_dup(original) }

    it 'has different object_id' do
      expect(original.object_id).to_not eq(dupped.object_id)
    end

    it 'strings have different object_id' do
      original_ids = original.map(&:object_id)
      dupped_ids   = dupped.map(&:object_id)

      expect(original_ids).to_not eq(dupped_ids)
    end
  end

  context 'Hash of things' do
    let(:original) { { message: 'Hi' } }
    let(:dupped)   { DeepDup.deep_dup(original) }

    it 'has different object_id' do
      expect(original.object_id).to_not eq(dupped.object_id)
    end

    it 'keys have same object_id (not duppable)' do
      original_ids = original.keys.map(&:object_id)
      dupped_ids   = dupped.keys.map(&:object_id)

      expect(original_ids).to eq(dupped_ids)
    end

    it 'values have different object_id' do
      original_ids = original.values.map(&:object_id)
      dupped_ids   = dupped.values.map(&:object_id)

      expect(original_ids).to_not eq(dupped_ids)
    end
  end

  context 'More complicated things' do
    let(:original) { ['a', :a, 1, ['a'], { b: { 'c' => 'd' } }] }
    let(:dupped)   { DeepDup.deep_dup(original) }

    it 'has different object_id' do
      expect(original.object_id).to_not eq(dupped.object_id)
    end

    it "'a' has different object_id" do
      original_thing = original.fetch(0)
      dupped_thing   = dupped.fetch(0)

      expect(original_thing.object_id).to_not eq(dupped_thing.object_id)
    end

    it ':a has same object_id' do
      original_thing = original.fetch(1)
      dupped_thing   = dupped.fetch(1)

      expect(original_thing.object_id).to eq(dupped_thing.object_id)
    end

    it '1 has same object_id' do
      original_thing = original.fetch(2)
      dupped_thing   = dupped.fetch(2)

      expect(original_thing.object_id).to eq(dupped_thing.object_id)
    end

    it 'subarray has different object_id' do
      original_thing = original.fetch(3)
      dupped_thing   = dupped.fetch(3)

      expect(original_thing.object_id).to_not eq(dupped_thing.object_id)
    end

    it "subarray 'a' has different object_id" do
      original_thing = original.fetch(3).fetch(0)
      dupped_thing   = dupped.fetch(3).fetch(0)

      expect(original_thing.object_id).to_not eq(dupped_thing.object_id)
    end

    it 'subhash has different object_id' do
      original_thing = original.fetch(4)
      dupped_thing   = dupped.fetch(4)

      expect(original_thing.object_id).to_not eq(dupped_thing.object_id)
    end

    it 'subhash key has same object_id' do
      original_thing = original.fetch(4).keys.fetch(0)
      dupped_thing   = dupped.fetch(4).keys.fetch(0)

      expect(original_thing.object_id).to eq(dupped_thing.object_id)
    end

    it 'subhash subhash has different object_id' do
      original_thing = original.fetch(4).values.fetch(0)
      dupped_thing   = dupped.fetch(4).values.fetch(0)

      expect(original_thing.object_id).to_not eq(dupped_thing.object_id)
    end

    it 'subhash subhash key has different object_id' do
      original_thing = original.fetch(4).values.fetch(0).keys.fetch(0)
      dupped_thing   = dupped.fetch(4).values.fetch(0).keys.fetch(0)

      expect(original_thing.object_id).to_not eq(dupped_thing.object_id)
    end

    it 'subhash subhash value has different object_id' do
      original_thing = original.fetch(4).values.fetch(0).values.fetch(0)
      dupped_thing   = dupped.fetch(4).values.fetch(0).values.fetch(0)

      expect(original_thing.object_id).to_not eq(dupped_thing.object_id)
    end
  end
end
