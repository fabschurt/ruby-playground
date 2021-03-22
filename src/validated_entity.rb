require 'date'

class Book
  attr_reader :title
  attr_reader :author_name
  attr_reader :publication_year

  def initialize(title:, author_name:, publication_date:)
    @title,
    @author_name,
    @publication_year,
      = validate(title, author_name, publication_date)
  end

  private

  def validate(title, author_name, publication_date)
    if
      !(title.is_a? String) ||
      title.empty?
    then
      fail ArgumentError, 'Title must be a non-empty string.'
    end

    if
      !(author_name.is_a? String) ||
      author_name.empty?
    then
      fail ArgumentError, 'Author name must be a non-empty string.'
    end

    if
      !(publication_date.is_a? Date)
    then
      fail ArgumentError, 'Publication year must be a date'
    end

    [
      title,
      author_name,
      publication_date.year
    ]
  end
end

moby_d = Book.new(
  title: 'Moby Dick',
  author_name: 'Herman Melville',
  publication_date: Date.new(1810, 10, 30),
)

pp moby_d
