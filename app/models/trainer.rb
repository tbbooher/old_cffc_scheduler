class Trainer < ActiveRecord::Base
  attr_accessible :name, :description, :phone
  has_many :schedules
  has_many :events, :through => :schedules
  validates_presence_of :name

  def blocks_this_month
    blocks_this_month = {}
    EventType.all.each_with_index do |et, index|
      blocks_this_month[et.name.to_sym] = self.events.select{|e| e.start_time >= Date.today.beginning_of_month && e.start_time <= Date.today.end_of_month && e.event_type == et}.size
    end
    return blocks_this_month
  end
end
