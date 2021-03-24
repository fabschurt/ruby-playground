require 'minitest/autorun'

def go_crazy(&block) = block_given? ? block.class : nil

describe 'Blocks and procs' do
  it 'is the same' do
    _(go_crazy { nil }).must_be_same_as Proc
  end
end
