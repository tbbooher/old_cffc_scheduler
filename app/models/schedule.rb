class Schedule < ActiveRecord::Base
  attr_accessible :trainer_id, :event_id
  belongs_to :trainer
  belongs_to :event
end
