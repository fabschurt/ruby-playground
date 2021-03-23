require 'minitest/autorun'

describe 'Modifying the load path' do
  it 'cannot find a lib class if not made discoverable' do
    _{ require 'lib/Character/Scout' }.must_raise LoadError
  end

  it 'is able to find lib classes once added to the load path' do
    $LOAD_PATH.prepend(File.expand_path(File.dirname(__FILE__)))
    require 'lib/Character/Scout'

    _(Scout.new.fight).must_equal 'Farewell…'
  end
end
