require 'minitest/autorun'

describe 'Looping' do
  it 'can be a block' do
    i = 0
    j = 0

    while i != 10 do
      i += 1
    end

    until j >= 5 do
      j += 1
    end

    expect(i).must_equal 10
    expect(j).must_equal 5
  end

  it 'can be inlined' do
    i = 0
    j = 0

    i += 1 while i < 3
    j += 2 until j == 10

    expect(i).must_equal 3
    expect(j).must_equal 10
  end

  it 'can be a good old `for` loop' do
    i = 0

    for x in 1..4 do
      i += x
    end

    expect(i).must_equal 10
  end
end

describe 'A `loop` block' do
  it 'must be manually broken' do
    i = 0

    loop do
      i += 1

      break if i % 3 == 0
    end

    expect(i).must_equal 3
  end

  it 'converts a `StopIteration` error to a break' do
    seq = [1, 2].cycle(1)

    seq.next
    seq.next

    expect { seq.next }.must_raise StopIteration

    seq.rewind

    loop do
      seq.next
    end
  end
end
