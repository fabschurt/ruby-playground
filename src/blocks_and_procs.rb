require 'minitest/autorun'

def get_block_class(&block) = block_given? ? block.class : nil

describe 'Blocks and procs' do
  it 'is the same' do
    expect(get_block_class { nil }).must_be_same_as Proc
  end
end
