class TimeSlot < ActiveRecord::Base
  attr_accessible :start_time, :title, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :event_type_id
  belongs_to :event_type
  has_many :events
  validates_presence_of :title
end
