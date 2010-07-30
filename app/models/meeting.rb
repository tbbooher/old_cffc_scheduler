class Meeting < ActiveRecord::Base
  attr_accessible :trainer_meeting_id, :meeting_type_id, :time_slot_id, :meeting_date, :duration, :trainer_ids
  has_many :schedules
  has_many :trainers, :through => :schedules
  belongs_to :time_slot
  belongs_to :meeting_type
  validates_presence_of :trainer_ids
end
