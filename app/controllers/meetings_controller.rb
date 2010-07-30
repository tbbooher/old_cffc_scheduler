class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end
  
  def show
    @meeting = Meeting.find(params[:id])
  end
  
  def new
    @meeting = Meeting.new
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
end
