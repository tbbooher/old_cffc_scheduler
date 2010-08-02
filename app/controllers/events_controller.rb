class EventsController < ApplicationController
  
  def new
    @event = Event.new(:start_time => Time.now(), :end_time => 1.hour.from_now, :period => "Does not repeat")
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
          e.time_slot_id = ts.id
          e.event_type = EventType.first
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
    if params[:event][:period] == "Does not repeat"
      @event = Event.new(params[:event])
    else
      #      @event_series = EventSeries.new(:frequency => params[:event][:frequency], :period => params[:event][:repeats], :start_time => params[:event][:start_time], :end_time => params[:event][:end_time], :all_day => params[:event][:all_day])
      @event_series = EventSeries.new(params[:event])
    end
  end
  
  def index
    
  end
  
  def get_events
    @events = Event.find(:all, :conditions => ["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
    events = [] 
    @events.each do |event|
      events << {:id => event.id, :title => event.coach_list, :description => event.description || "Some cool description here...", :start => "#{event.start_time.iso8601}", :end => "#{event.end_time.iso8601}", :allDay => event.all_day, :recurring => (event.event_series_id)? true: false}
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
    if params[:event][:commit_button] == "Update All Occurrence"
      @events = @event.event_series.events #.find(:all, :conditions => ["start_time > '#{@event.start_time.to_formatted_s(:db)}' "])
      @event.update_events(@events, params[:event])
    elsif params[:event][:commit_button] == "Update All Following Occurrence"
      @events = @event.event_series.events.find(:all, :conditions => ["start_time > '#{@event.start_time.to_formatted_s(:db)}' "])
      @event.update_events(@events, params[:event])
    else
      @event.attributes = params[:event]
      @event.save
    end

    render :update do |page|
      page<<"$('#calendar').fullCalendar( 'refetchEvents' )"
      page<<"$('#desc_dialog').dialog('destroy')" 
    end
    
  end  
  
  def destroy
    @event = Event.find_by_id(params[:id])
    if params[:delete_all] == 'true'
      @event.event_series.destroy
    elsif params[:delete_all] == 'future'
      @events = @event.event_series.events.find(:all, :conditions => ["start_time > '#{@event.start_time.to_formatted_s(:db)}' "])
      @event.event_series.events.delete(@events)
    else
      @event.destroy
    end
    
    render :update do |page|
      page<<"$('#calendar').fullCalendar( 'refetchEvents' )"
      page<<"$('#desc_dialog').dialog('destroy')" 
    end
    
  end

  def payroll
    @trainers = []
    Trainer.all.each do |t|
      @trainers << [t.name, t.blocks_this_month]
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
