require 'minitest/autorun'

module Animal
  def exist = 'I am.'

  def cry
    raise NotImplementedError
  end
end

class Dog
  include Animal

  def cry = 'Bark!'
end

describe 'The Class class' do
  it 'extends from the Module class' do
    _(Class.superclass).must_be_same_as Module
  end

  it 'can be anonymously defined (inlined)' do
    Cat = Class.new do
      include Animal

      def cry = 'Meow!'
    end

    skippy = Cat.new

    _(skippy.class).must_be_same_as Cat
    _(skippy.exist).must_equal 'I am.'
    _(skippy.cry).must_equal 'Meow!'
  end

  it 'can be instantiated' do
    rex = Dog.new

    _(rex.class).must_be_same_as Dog
  end
end

describe 'The Module class' do
  it 'can be anonymously defined (inlined)' do
    Bird = Module.new do
      def fly = '*Flap flap flap!*'
    end

    class Duck
      include Bird
    end

    daffy = Duck.new

    _(daffy.fly).must_equal '*Flap flap flap!*'
  end

  it 'can be reopened (keeping the inheritance chain consistent)' do
    module Animal
      def be_quiet = '…'
    end

    lassie = Dog.new

    _(lassie.be_quiet).must_equal '…'
  end

  it 'cannot be instantiated' do
    _{ Animal.new }.must_raise NoMethodError
  end
end
