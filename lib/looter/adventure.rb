class Adventure

  attr_reader :title

  def initialize(title, rooms)
    @title = title
    @rooms = rooms
  end

  def self.from_hash(configuration_hash)
    Adventure.new(configuration_hash['title'], [])
  end

  def room(room_id)
    @rooms.find { |room| room.id == room_id }
  end

end

Room = Struct.new(:id, :name) do
end
