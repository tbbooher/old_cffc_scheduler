class Coach < ActiveRecord::Base
  attr_accessible :name, :description, :phone
  has_many :schedules
  has_many :events, :through => :schedules
  validates_presence_of :name

  def blocks_this_month(a_date)
    blocks_this_month = {}
    EventType.all.each do |et|
      blocks_this_month[et.name.to_sym] = self.events.select{|e| e.start_time >= a_date.beginning_of_month.start_of_day && e.start_time <= a_date.end_of_month.end_of_day && e.event_type == et}.size
    end
    return blocks_this_month
  end
end
