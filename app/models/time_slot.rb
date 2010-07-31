class TimeSlot < ActiveRecord::Base
  attr_accessible :start_time
  has_many :meetings
  has_many :days
end
