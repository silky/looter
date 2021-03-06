require 'spec_helper'

describe Room do
  let(:room) do
    Room.new(:room, 'Room', 'Some room', [
             Exit.new(:left, "Left way"),
             Exit.new(:right, "Right way")
    ])
  end

  it 'maps names of exits' do
    room.exit_names.should == ["Left way", "Right way"]
  end

  it 'maps rooms of exits' do
    room.exit_rooms.should == [:left, :right]
  end

  it 'has exit to adjacent rooms' do
    room.has_exit?(:left).should be_true
    room.has_exit?(:right).should be_true
    room.has_exit?(:center).should be_false
  end
end
