require 'minitest/autorun'

def build_hash(arg1: 5, arg2:, arg3:) = { a: arg1, b: arg2, c: arg3 }

describe 'Keyword argument passing' do
  it 'fails if an argument is missing' do
    expect { build_hash(arg3: 'foo') }.must_raise ArgumentError
  end

  it 'fails if an additional argument is passed' do
    expect { build_hash(arg2: 'foo', arg3: 'bar', arg4: 'argh') }.must_raise ArgumentError
  end

  it 'accepts only the right number of arguments' do
    hash = build_hash(arg2: 42, arg3: 'foo')

    expect(hash[:a]).must_equal 5
    expect(hash[:b]).must_equal 42
    expect(hash[:c]).must_equal 'foo'
  end
end
