require 'minitest/autorun'

describe String do
  it 'can be formatted with the `%` syntax' do
    vars = ['Jack', 32, 'engineer']

    expect(
      'Hi, I’m %s, I’m a %d-year-old %s.' % vars
    ).must_equal 'Hi, I’m Jack, I’m a 32-year-old engineer.'
  end

  it 'can be formatted with `Kernel#format` or `Kernel#sprintf`' do
    vars = ['pie', Math::PI]

    expect(
      sprintf('Do you like apple %s? No, I prefer apple %.2f.', *vars)
    ).must_equal 'Do you like apple pie? No, I prefer apple 3.14.'

    expect(method(:sprintf)).must_equal method(:format)
  end

  it 'can be formatted with named placeholders' do
    vars = { name: 'Robert', age: 54.556 }

    expect(
      'Hi, I’m %{name}, and I’m %{age}-year old.' % vars
    ).must_equal 'Hi, I’m Robert, and I’m 54.556-year old.'

    expect(
      sprintf('%<name>s is my name, and %<age>.1f is my age.', vars)
    ).must_equal 'Robert is my name, and 54.6 is my age.'
  end

  it 'can be padded' do
    words = %w(earth wind fire transparent_liquid_stuff)
    max_length = words.map { |word| word.length }.max

    expect(
      words
        .map { |word| word.rjust(max_length, '-') }
        .join("\n")
    ).must_equal <<~STR.chomp
      -------------------earth
      --------------------wind
      --------------------fire
      transparent_liquid_stuff
    STR
  end
end
