require 'set'
require 'minitest/autorun'

describe 'An `Enumerable` object' do
  it 'can be zipped with another enumerable' do
    expect(['a', 'b', 'c'].zip([2, 6, 9])).must_equal [['a', 2], ['b', 6], ['c', 9]]
    expect(['a', 'b', 'c'].zip([2])).must_equal [['a', 2], ['b', nil], ['c', nil]]
  end

  it 'can be converted to a hash' do
    expect([[:a, 5], [:b, 6], [:c, 12]].to_h).must_equal({a: 5, b: 6, c: 12})
  end

  it 'can be converted to a set' do
    expect([5, 5, 6, 7, 9, 9].to_set).must_equal Set.new([5, 6, 7, 9])
  end
end

describe 'An `Enumerator` object' do
  it 'is returned when calling most `Enumerable` methods without passing a block' do
    ary = []

    expect(ary.to_enum).must_be_instance_of Enumerator
    expect(ary.each).must_be_instance_of Enumerator
    expect(ary.map).must_be_instance_of Enumerator
    expect(ary.filter).must_be_instance_of Enumerator
  end

  it 'allows for external iteration' do
    enum = ['red', 'blue', 'tangerine'].each

    expect(enum.next).must_equal 'red'
    expect(enum.next).must_equal 'blue'
    expect(enum.next).must_equal 'tangerine'
    expect { enum.next }.must_raise StopIteration
  end

  it 'allows for chaining enumeration logic' do
    ary = ['foo', 'bar', 'spam', 'eggs']

    expect(
      ary
        .reverse_each
        .with_index # This is an `Enumerator` method, but `Enumerable#each_with_index` would work too.
        .map { |value, index| "#{index + 1}_#{value}" }
    ).must_equal [
      '1_eggs',
      '2_spam',
      '3_bar',
      '4_foo',
    ]
  end

  it 'can be lazy' do
    infinite_range = (0..) # Equivalent to `(0..Float.INFINITY)`.

    # Without using `Enumerable#lazy` here, the implementation of `Enumerable#zip` would dictate iterating the whole
    # infinite range, hence blocking execution and filling the RAM up to crashing the OS.
    expect(infinite_range.lazy.zip([2, 4, 6]).first(3)).must_equal [[0, 2], [1, 4], [2, 6]]
    expect(infinite_range.lazy.zip([2, 4, 6]).take(2).force).must_equal [[0, 2], [1, 4]]
  end

  it 'can be chained' do
    chained_enum = [5, 6].to_enum + [4, 9].to_enum

    expect(chained_enum).must_be_kind_of Enumerator
    expect(chained_enum.to_a).must_equal [5, 6, 4, 9]
    expect(chained_enum.chain([1, 5].to_enum).to_a).must_equal [5, 6, 4, 9, 1, 5]
  end
end
