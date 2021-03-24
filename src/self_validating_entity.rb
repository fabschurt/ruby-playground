require 'date'
require 'minitest/autorun'

class Book
  attr_reader :title
  attr_reader :author_name
  attr_reader :publication_year

  def initialize(title:, author_name:, publication_date:)
    @title,
    @author_name,
    @publication_year,
    =
    validate(
      title,
      author_name,
      publication_date,
    )
  end

  private

  def validate(title, author_name, publication_date)
    if !(title.is_a? String) || title.empty?
      fail ArgumentError, 'Title must be a non-empty string.'
    end

    if !(author_name.is_a? String) || author_name.empty?
      fail ArgumentError, 'Author name must be a non-empty string.'
    end

    if !(publication_date.is_a? Date)
      fail ArgumentError, 'Publication year must be a date'
    end

    [
      title,
      author_name,
      publication_date.year,
    ]
  end
end

describe 'A self-validating entity' do
  subject { Book }

  it 'fails when crappy args are passed to its constructor' do
    _{ subject.new(crap: false) }.must_raise ArgumentError
    _{ subject.new(42, 'Jack London', 3444) }.must_raise ArgumentError
    _{ subject.new('Fight Club', 'Some dude with a weird name', Date.new(1996, 8, 17)) }.must_raise ArgumentError
  end

  it 'validates itself upon initialization' do
    book = subject.new(
      title: 'Fahrenheit 451',
      author_name: 'Ray Bradbury',
      publication_date: Date.new(1953, 10, 19),
    )

    _(book.title).must_equal 'Fahrenheit 451'
    _(book.author_name).must_equal 'Ray Bradbury'
    _(book.publication_year).must_equal 1953
  end
end
