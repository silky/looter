require 'spec_helper'
require 'YAML'

describe SaveGame do
  let(:adventure) do
    Adventure.new('Testing rooms', [
      Room.new(:start, 'First', nil, [ Exit.new(:left, "Left"), Exit.new(:right, "Right") ]),
      Room.new(:left, 'Left', nil, [ Exit.new(:another, "Another") ]),
      Room.new(:right, 'Right', nil, [ Exit.new(:no_way, "No way") ]),
      Room.new(:another, 'Final destination', nil, [])
    ])
  end

  it 'saves current room from adventure' do
    adventure.travel_to(:right)

    save_game = SaveGame.new('/tmp/save_file.yaml')
    save_game.save(adventure)

    YAML.load_file('/tmp/save_file.yaml').should == { 'current_room' => :right }
  end

  it 'loads current adventure from save game' do
    pending
    save = { "current_room" => :another }
    File.open("/tmp/save_file.yaml", 'w') { |f| f.write(save.to_yaml) }

    save_game = SaveGame.new('/tmp/save_file.yaml')
    save_game.load(adventure)

    adventure.current_room.id.should == :another
  end

end
