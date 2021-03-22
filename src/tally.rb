require 'net/http'
require 'logger'

LOREM_URI = 'https://baconipsum.com/api/?type=meat-and-filler&paras=2&format=text'

logger = Logger.new(STDERR)

begin
  lorem_txt = Net::HTTP.get(URI(LOREM_URI))
rescue Net::HTTPError, SocketError => error
  logger.fatal(error.inspect)
  exit 1
end

lorem_txt
  .split(/\W+/)
  .filter { |word| !word.empty? }
  .map(&:downcase)
  .tally
  .group_by { |word, count| count }
  .transform_values { |word_count_tuple| word_count_tuple.map(&:first) }
  .sort
  .reverse
  .to_h
  .each do |count, words|
    heading = "#{count}-occurrence words"

    puts <<~GROUP

      #{heading}
      #{'=' * heading.length}

      #{words.each_slice(7).map { |word_group| word_group.join(', ') }.join("\n")}

    GROUP
  end
