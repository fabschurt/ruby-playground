require 'minitest/autorun'

module Animal
  def exist = 'I am.'

  def make_sound
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

  def make_sound = 'Bark!'
end

describe Module do
  it 'can be reopened (immediately updating the lookup chain)' do
    lassie = Dog.new

    module Animal
      def be_quiet = '…'
    end

    expect(lassie.be_quiet).must_equal '…'
  end

  it 'can be added additional class methods to' do
    def Animal.all = :every_animal_on_the_planet

    module Animal
      def self.none = :no_animal
    end

    expect(Animal.all).must_equal :every_animal_on_the_planet
    expect(Animal.none).must_equal :no_animal
  end

  it 'can be anonymous/inline' do
    Bird = Module.new do
      def fly = '*Flap flap flap!*'
    end

    class Duck
      include Bird
    end

    daffy = Duck.new

    expect(daffy.fly).must_equal '*Flap flap flap!*'
  end

  it 'can have methods that are both instance and class methods' do
    expect(Animal.exist).must_equal 'I am.'
    expect(Dog.new.send(:exist)).must_equal 'I am.' # The instance version is made private by default, so we need to use `Object#send` here.
  end

  it 'can extend itself to act as a library of functions' do
    expect(Mathematics.add(1, 2)).must_equal 3
  end

  it 'cannot extend private methods' do
    expect { Mathematics.sub(2, 1) }.must_raise NoMethodError
  end

  it 'cannot be instantiated' do
    expect { Animal.new }.must_raise NoMethodError
  end
end

describe Class do
  it 'extends from the `Module` class' do
    expect(Class.superclass).must_be_kind_of Module
  end

  it 'can be reopened' do
    missy = Dog.new

    class Dog
      def sit = 'Yaf!'
    end

    expect(missy.sit).must_equal 'Yaf!'
  end

  it 'can be added additional class methods to' do
    def Dog.all = ['Rex', 'Lassie', 'Beethoven']

    class Dog
      def self.none = []
    end

    expect(Dog.all).must_equal ['Rex', 'Lassie', 'Beethoven']
    expect(Dog.none).must_equal []
  end

  it 'can be anonymous/inline' do
    Cat = Class.new do
      include Animal

      def make_sound = 'Meow!'
    end

    skippy = Cat.new

    expect(skippy).must_be_instance_of Cat
    expect(skippy.make_sound).must_equal 'Meow!'
  end

  it 'allows for matching the type of the class but also the module' do
    some_dog = Dog.new

    expect(some_dog).must_be_kind_of Dog
    expect(some_dog).must_be_kind_of Animal
  end

  it 'provides a `#===` method for type matching' do
    chase = Dog.new

    # Note that you can’t invert the order of the operands here, because `===`
    # is just some syntactic sugar for calling `#===` on the left-hand operand.
    assert(Dog === chase)
    assert(Animal === chase)
    refute(chase === Dog)
    refute(Mathematics === chase)

    chase_type =
      case chase # `case` uses `#===` for comparison
        when Mathematics then :maths
        when Dog then :dog
      end

    expect(chase_type).must_equal(:dog)
  end

  it 'can be instantiated' do
    rex = Dog.new

    expect(rex).must_be_instance_of Dog
  end
end
