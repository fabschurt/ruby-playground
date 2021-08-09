require 'minitest/autorun'

describe 'A «begin» block' do
  it 'can encapsulate a procedure' do
    what_the_fox_says = begin
      fox_words = []
      fox_words << 'Tiling tiling!'
      fox_words << 'Cuh cuh cuh cuh cuh cuh!'
    end

    expect(what_the_fox_says).must_equal [
      'Tiling tiling!',
      'Cuh cuh cuh cuh cuh cuh!',
    ]
  end

  it 'has the same semantics than a «def» block' do
    def explode
      fail 'BOOM!'
    rescue
      'This is fine.'
    end

    expect(explode).must_equal 'This is fine.'
  end
end
