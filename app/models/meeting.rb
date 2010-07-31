class Meeting < ActiveRecord::Base
  attr_accessible :trainer_meeting_id, :meeting_type_id, :time_slot_id, :meeting_date, :duration, :trainer_ids, :period, :frequency, :commit_button
  has_many :schedules
  has_many :trainers, :through => :schedules
  belongs_to :time_slot
  belongs_to :meeting_type
  # validations
  validates_presence_of :trainer_ids, :title

  REPEATS = [
              "Does not repeat",
              "Daily"          ,
              "Weekly"         ,
              "Monthly"        ,
              "Yearly"         
  ]
  
  def validate
    if (starttime >= endtime) and !all_day
      errors.add_to_base("Start Time must be less than End Time")
    end
  end
  
  def update_meetings(meetings, meeting)
    meetings.each do |e|
      begin 
        st, et = e.starttime, e.endtime
        e.attributes = meeting
        if meeting_series.period.downcase == 'monthly' or meeting_series.period.downcase == 'yearly'
          nst = DateTime.parse("#{e.starttime.hour}:#{e.starttime.min}:#{e.starttime.sec}, #{e.starttime.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{e.endtime.hour}:#{e.endtime.min}:#{e.endtime.sec}, #{e.endtime.day}-#{et.month}-#{et.year}")
        else
          nst = DateTime.parse("#{e.starttime.hour}:#{e.starttime.min}:#{e.starttime.sec}, #{st.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{e.endtime.hour}:#{e.endtime.min}:#{e.endtime.sec}, #{et.day}-#{et.month}-#{et.year}")
        end
        #puts "#{nst}           :::::::::          #{net}"
      rescue
        nst = net = nil
      end
      if nst and net
        #          e.attributes = meeting
        e.starttime, e.endtime = nst, net
        e.save
      end
    end
    
    meeting_series.attributes = meeting
    meeting_series.save
  end
  


end
