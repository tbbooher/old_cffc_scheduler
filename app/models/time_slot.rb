class TimeSlot < ActiveRecord::Base
  attr_accessible :start_time, :title, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday
  has_many :meetings
  has_many :days
end
