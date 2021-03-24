require 'minitest/autorun'

describe 'Class loading' do
  it 'fails if class is not discoverable' do
    _{ require 'lib/Character/Scout' }.must_raise LoadError
  end

  it 'succeeds once the class is added to the load path' do
    SRC_PATH = File.expand_path(File.dirname(__FILE__))

    $LOAD_PATH.push(SRC_PATH)
    require 'lib/Character/Scout'

    _(Scout.new.fight).must_equal 'Farewell…'

    $LOAD_PATH.pop # restore original load path
  end
end
