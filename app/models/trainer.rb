class Trainer < ActiveRecord::Base
  attr_accessible :name, :description, :phone
  has_many :schedules
  has_many :events, :through => :schedules
  validates_presence_of :name
end
