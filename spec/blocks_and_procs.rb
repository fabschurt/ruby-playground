require 'minitest/autorun'

describe Proc do
  it 'is can be passed as a «block»' do
    def get_block_class(&block) = block ? block.class : nil

    expect(get_block_class { }).must_be_same_as Proc
  end

  it 'is callable via a few different ways' do
    tell_me_why = ->(how) { "I want it #{how} way." }

    expect(tell_me_why.('that')).must_equal 'I want it that way.' # Only methods can be called without using the dot.
    expect(tell_me_why['this']).must_equal 'I want it this way.'
    expect(tell_me_why.call('no')).must_equal 'I want it no way.'
    expect(tell_me_why.yield('either')).must_equal 'I want it either way.'
  end

  it 'handles an invalid argument count differently if it is a lambda' do
    the_proc = proc { |x, y| x }
    the_lambda = ->(x, y) { x + y }

    expect(the_proc.(4)).must_equal 4 # Regulars procs don’t care about argument count.
    expect { the_lambda.(4) }.must_raise ArgumentError # Lambdas crash if the argument count is invalid.
  end
end

describe 'A «block»' do
  def yield_implicitly = block_given? ? yield : nil

  def yield_explicitly(&block) = block ? block.() : nil

  it 'has 2 different syntaxes' do
    def meaning_of_life?
      if block_given?
        yield 42
      end
    end

    meaning_of_life? do |the_meaning_of_life|
      expect(the_meaning_of_life).must_equal 42
    end

    meaning_of_life? { |the_meaning_of_life| expect(the_meaning_of_life).must_equal 42 }
  end

  it 'can be passed and executed implicitly' do
    expect(yield_implicitly { 42 }).must_equal 42
  end

  it 'can be passed explicitly and executed implicitly' do
    some_block = -> { 43 }

    expect(yield_implicitly(&some_block)).must_equal 43
  end

  it 'can be passed implicitly and executed explicitly' do
    expect(yield_explicitly { 44 }).must_equal 44
  end

  it 'can be passed and executed explicitly' do
    a_block = -> { 45 }

    expect(yield_explicitly(&a_block)).must_equal 45
  end
end
