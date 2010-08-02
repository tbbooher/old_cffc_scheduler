class Schedule < ActiveRecord::Base
  attr_accessible :coach_id, :event_id
  belongs_to :coach
  belongs_to :event
end
