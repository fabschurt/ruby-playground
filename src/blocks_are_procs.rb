require 'minitest/autorun'

def go_crazy(&block) = block_given? ? block.class : nil

describe 'Blocks are procs' do
  it 'is the same' do
    _(go_crazy {}).must_be_same_as(Proc)
  end
end
