require 'minitest/autorun'

describe 'An `Enumerator` object' do
  it 'is returned when calling most `Enumerable` methods without passing a block' do
    ary = []

    _(ary.each).must_be_instance_of Enumerator
    _(ary.map).must_be_instance_of Enumerator
    _(ary.filter).must_be_instance_of Enumerator
  end

  it 'allows for external iteration' do
    enum = [
      'red',
      'blue',
      'tangerine',
    ].each

    _(enum.next).must_equal 'red'
    _(enum.next).must_equal 'blue'
    _(enum.next).must_equal 'tangerine'
    _{ enum.next }.must_raise StopIteration
  end

  it 'allows for chaining enumeration logic' do
    ary = [
      'foo',
      'bar',
      'spam',
      'eggs',
    ]

    _(
      ary
        .reverse_each
        .with_index # this is an `Enumerator` method, but `Enumerable#each_with_index` would work too
        .map { |value, index| "#{index + 1}_#{value}" }
    ).must_equal [
      '1_eggs',
      '2_spam',
      '3_bar',
      '4_foo',
    ]
  end
end
