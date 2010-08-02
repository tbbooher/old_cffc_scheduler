class EventsController < ApplicationController
  
  def new
    @event = Event.new(:start_time => Time.now(), :end_time => 1.hour.from_now)
  end

  def populate
    inspection_date = Date.today
    month = inspection_date.month
    year = inspection_date.year
    TimeSlot.all.each do |ts|
      hour, min = ts.start_time.hour, ts.start_time.min
      (inspection_date.beginning_of_month.day..inspection_date.end_of_month.day).to_a.each do |day|
        start_time = Time.local(year,month,day,hour,min,0)   #=> Sat Jan 01 20:15:01 CST 2000
        if date_match(ts,start_time.strftime('%A'))
          e = Event.new
          e.start_time = start_time
          e.end_time = Time.local(year,month,day,hour+1,min,0)   #=> Sat Jan 01 20:15:01 CST 2000
          e.event_type = ts.event_type
          e.title = ts.title
          e.save!
        end
      end
    end
  end

  def empty_out_month
    inspection_date = Date.today
    Event.destroy_all{|e| e.start_time.month == inspection_date.month && e.start_time.year = inspection_date.year}
  end

  def create
    if params[:event]
      @event = Event.new(params[:event])
    else
      # error!
      raise "error!"
    end
  end
  
  def index
    
  end
  
  def get_events
    @events = Event.find(:all, :conditions => ["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
    events = [] 
    @events.each do |event|
      events << {:id => event.id, :title => event.coach_list, :description => event.description || "Some cool description here...", :start => "#{event.start_time.iso8601}", :end => "#{event.end_time.iso8601}", :allDay => event.all_day, :recurring => false, :className => event.event_type.name }
    end
    render :text => events.to_json
  end
  
  def move
    @event = Event.find_by_id params[:id]
    if @event
      @event.start_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.start_time))
      @event.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.end_time))
      @event.all_day = params[:all_day]
      @event.save
    end
  end

  def resize
    @event = Event.find_by_id params[:id]
    if @event
      @event.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.end_time))
      @event.save
    end    
  end
  
  def edit
    @event = Event.find_by_id(params[:id])
  end
  
  def update
    @event = Event.find_by_id(params[:event][:id])
    @event.attributes = params[:event]
    @event.save

    render :update do |page|
      page<<"$('#calendar').fullCalendar( 'refetchEvents' )"
      page<<"$('#desc_dialog').dialog('destroy')" 
    end
    
  end  
  
  def destroy
    @event = Event.find_by_id(params[:id])
    @event.destroy
    
    render :update do |page|
      page<<"$('#calendar').fullCalendar( 'refetchEvents' )"
      page<<"$('#desc_dialog').dialog('destroy')" 
    end
    
  end

  def payroll
    @coaches = []
    Coach.all.each do |t|
      @coaches << [t.name, t.blocks_this_month]
    end
    @types = EventType.all.map{|et| et.name}
  end

  private

  def date_match(ts, day_name)
    Date::DAYNAMES.each do |weekday|
       return true if (ts.send(weekday.downcase) && (weekday == day_name))
    end
    return false
  end
  
end
