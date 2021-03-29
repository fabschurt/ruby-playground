require 'minitest/autorun'

SRC_PATH = File.expand_path(File.dirname(__FILE__))

describe 'Class loading' do
  it 'fails if class is not discoverable' do
    _{ require 'lib/Character/Scout' }.must_raise LoadError
  end

  it 'succeeds once the class is added to the load path' do
    $LOAD_PATH.push(SRC_PATH)
    require 'lib/Character/Scout'

    Scout.new

    $LOAD_PATH.pop # Restores the original load path and avoids messing with global state.
  end
end
