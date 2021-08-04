require 'minitest/autorun'

LIB_PATH = File.expand_path(File.dirname(File.dirname(__FILE__)))

describe 'Class loading' do
  it 'fails if class is not discoverable' do
    expect { require 'lib/Character/Scout' }.must_raise LoadError
  end

  it 'succeeds once the class is added to the load path' do
    $LOAD_PATH.push(LIB_PATH)
    require 'lib/Character/Scout'

    expect(Scout.new.fight).must_equal 'Farewell…'

    $LOAD_PATH.pop # Restores the original load path and avoids messing with global state.
  end
end
