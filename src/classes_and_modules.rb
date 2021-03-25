require 'minitest/autorun'

module Animal
  def exist = 'I am.'

  def cry
    raise NotImplementedError
  end

  module_function :exist
end

module Mathematics
  def add(a, b) = a + b

  private

  def sub(a, b) = a - b

  extend self
end

class Dog
  include Animal

  def cry = 'Bark!'
end

describe 'The Module class' do
  it 'can be reopened (keeping the inheritance chain consistent)' do
    lassie = Dog.new

    module Animal
      def be_quiet = '…'
    end

    _(lassie.be_quiet).must_equal '…'
  end

  it 'can be added additional class methods to' do
    def Animal.all = :every_animal_on_the_planet

    module Animal
      def self.none = :no_animal
    end


    _(Animal.all).must_equal :every_animal_on_the_planet
    _(Animal.none).must_equal :no_animal
  end

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

  it 'can have methods that are both instance and class methods' do
    _(Animal.exist).must_equal 'I am.'
    _(Dog.new.send(:exist)).must_equal 'I am.'
  end

  it 'can extend itself to act as a library of functions' do
    _(Mathematics.add(1, 2)).must_equal 3
  end

  it 'cannot extend private methods' do
    _{ Mathematics.sub(2, 1) }.must_raise NoMethodError
  end

  it 'cannot be instantiated' do
    _{ Animal.new }.must_raise NoMethodError
  end
end

describe 'The Class class' do
  it 'extends from the Module class' do
    _(Class.superclass).must_be_same_as Module
  end

  it 'can be reopened' do
    missy = Dog.new

    class Dog
      def sit = 'Yaf!'
    end

    _(missy.sit).must_equal 'Yaf!'
  end

  it 'can be added additional class methods to' do
    def Dog.all = ['Rex', 'Lassie', 'Beethoven']

    class Dog
      def self.none = []
    end

    _(Dog.all).must_equal ['Rex', 'Lassie', 'Beethoven']
    _(Dog.none).must_equal []
  end

  it 'can be anonymously defined (inlined)' do
    Cat = Class.new do
      include Animal

      def cry = 'Meow!'
    end

    skippy = Cat.new

    _(skippy).must_be_instance_of Cat
    _(skippy.cry).must_equal 'Meow!'
  end

  it 'allows for matching the type of the class but also the module' do
    some_dog = Dog.new

    _(some_dog).must_be_kind_of Dog
    _(some_dog).must_be_kind_of Animal
  end

  it 'can be instantiated' do
    rex = Dog.new

    _(rex).must_be_instance_of Dog
  end
end
