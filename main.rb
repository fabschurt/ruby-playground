$LOAD_PATH.prepend(
  File.join(
    File.expand_path(File.dirname(__FILE__)),
    'lib'
  )
)

require 'date'

class Book
  attr_accessor :title, :author_name, :publication_year

  def initialize(title:, author_name:, publication_year:)
    validate(
      title: title,
      author_name: author_name,
      publication_year: publication_year
    )

    @title = title
    @author_name = author_name
    @publication_year = publication_year
  end

  private

    def validate(title:, author_name:, publication_year:)
      if
        ! title.is_a? String ||
        title.is_empty?
      then fail ArgumentError, 'Title must be a non-empty string.' end

      if
        ! author_name.is_a? String ||
        author_name.is_empty?
      then fail ArgumentError, 'Author name must be a non-empty string.' end

      if
        ! publication_year.is_a? Date
      then fail ArgumentError, 'Publication year must be a date' end
    end
end

moby_d = Book.new(
  publication_year: Date.new(1810, 10, 30),
  title: 'Moby D.',
  author_name: 'Herman Melville'
)

pp moby_d
