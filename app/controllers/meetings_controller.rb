class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end
  
#  def show
#    @meeting = Meeting.find(params[:id])
#  end
  
  def new
    @meeting = Meeting.new(:endtime => 1.hour.from_now, :period => "Does not repeat")
  end
  
  def create
    @meeting = Meeting.new(params[:meeting])
    if @meeting.save
      flash[:notice] = "Successfully created meeting."
      redirect_to @meeting
    else
      render :action => 'new'
    end
  end
  
  def edit
    @meeting = Meeting.find(params[:id])
  end
  
  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update_attributes(params[:meeting])
      flash[:notice] = "Successfully updated meeting."
      redirect_to @meeting
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy
    flash[:notice] = "Successfully destroyed meeting."
    redirect_to meetings_url
  end

  # --------------------------------------------------
  #     EXTRA METHODS ADDED FOR AJAX MANIPULATION
  # --------------------------------------------------

  def get_meetings
    @meetings = Meeting.find(:all, :conditions => ["starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
    meetings = [] 
    @meetings.each do |meeting|
      meetings << {:id => meeting.id, :title => meeting.title, :description => meeting.description || "Some cool description here...", :start => "#{meeting.starttime.iso8601}", :end => "#{meeting.endtime.iso8601}", :allDay => meeting.all_day, :recurring => (meeting.meeting_series_id)? true: false}
    end
    render :text => meetings.to_json
  end
  
  def move
    @meeting = Meeting.find_by_id params[:id]
    if @meeting
      @meeting.starttime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@meeting.starttime))
      @meeting.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@meeting.endtime))
      @meeting.all_day = params[:all_day]
      @meeting.save
    end
  end
  
  def resize
    @meeting = Meeting.find_by_id params[:id]
    if @meeting
      @meeting.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@meeting.endtime))
      @meeting.save
    end    
  end

end
