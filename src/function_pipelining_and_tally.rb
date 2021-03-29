require 'minitest/autorun'

LOREM = <<~TXT
  Lorem ipsum dolor sed amet, consectetur adipiscing dolor.
  Sed, do ipsum tempor incididunt do: labore do dolore magna aliqua!
TXT

extract_words = ->(str) { str.split(/\W+/) }

filter_out_empty_words = ->(words) {
  words.filter { |word| !word.empty? }
}

downcase_words = ->(words) { words.map(&:downcase) }

count_words = ->(words) { words.tally }

group_words_by_count = ->(counted_words) {
  counted_words.group_by { |word, count| count }
}

cleanup_grouped_words = ->(grouped_words) {
  remove_count_from_tuple = ->(word_count_tuple) { word_count_tuple.map(&:first) }

  grouped_words.transform_values(&remove_count_from_tuple)
}

sort_grouped_words = ->(grouped_words) {
  grouped_words
    .sort
    .reverse
    .to_h
}

describe 'Function pipelining' do
  expected = {
    3 => [
      'do',
    ],
    2 => [
      'ipsum',
      'dolor',
      'sed',
    ],
    1 => [
      'lorem',
      'amet',
      'consectetur',
      'adipiscing',
      'tempor',
      'incididunt',
      'labore',
      'dolore',
      'magna',
      'aliqua',
    ],
  }

  it 'can be used with `Kernel#then`' do
    expect(
      LOREM
        .then(&extract_words)
        .then(&filter_out_empty_words)
        .then(&downcase_words)
        .then(&count_words)
        .then(&group_words_by_count)
        .then(&cleanup_grouped_words)
        .then(&sort_grouped_words)
    ).must_equal expected
  end

  it 'can be used with `Proc#`>>' do
    pipeline =
      extract_words >>
      filter_out_empty_words >>
      downcase_words >>
      count_words >>
      group_words_by_count >>
      cleanup_grouped_words >>
      sort_grouped_words

    expect(pipeline.call(LOREM)).must_equal expected
  end
end
