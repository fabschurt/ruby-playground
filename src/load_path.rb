$LOAD_PATH.prepend(File.expand_path(File.dirname(__FILE__)))

require 'test/unit/assertions'
require 'lib/Character'
require 'lib/Character/Scout'
require 'lib/Character/Tank'

include Test::Unit::Assertions

assert_raise NotImplementedError do
  Character.new().fight()
end

joe = Scout.new()
jack = Tank.new()

puts <<-BATTLE
Joe’s fighting: «#{joe.fight()}»
Jack’s fighting: «#{jack.fight()}»
BATTLE
