class EventType
  attr_accessor :id
  attr_accessor :name

  class << self
    attr_accessor :unit
  end

  def initialize(args)
    self.id = args[:id]
    self.name = args[:name]
  end

  def self.all
    [
      EventType.new(id: 'unit_meeting',      name: "#{ unit.type } Meeting"),
      EventType.new(id: 'camping',           name: 'Camping'),
      EventType.new(id: 'community_service', name: 'Community Service'),
      EventType.new(id: 'eagle_project',     name: 'Eagle Project'),
      EventType.new(id: 'fundraiser',        name: 'Fundraiser'),
      EventType.new(id: 'award_ceremony',    name: 'Award Ceremony'),
      EventType.new(id: 'football',          name: 'Football Game'),
      EventType.new(id: 'baseball',          name: 'Baseball Game'),
      EventType.new(id: 'afloat',            name: 'Boat or Raft'),
      EventType.new(id: 'swimming',          name: 'Swimming'),
      EventType.new(id: 'hiking',            name: 'Hiking'),
      EventType.new(id: 'training',          name: 'Training'),
      EventType.new(id: 'no_event',          name: 'No Meeting (skip)'),
    ]
  end
end
