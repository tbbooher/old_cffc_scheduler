class MeetingTypesController < ApplicationController
  def index
    @meeting_types = MeetingType.all
  end
  
  def show
    @meeting_type = MeetingType.find(params[:id])
  end
  
  def new
    @meeting_type = MeetingType.new
  end
  
  def create
    @meeting_type = MeetingType.new(params[:meeting_type])
    if @meeting_type.save
      flash[:notice] = "Successfully created meeting type."
      redirect_to @meeting_type
    else
      render :action => 'new'
    end
  end
  
  def edit
    @meeting_type = MeetingType.find(params[:id])
  end
  
  def update
    @meeting_type = MeetingType.find(params[:id])
    if @meeting_type.update_attributes(params[:meeting_type])
      flash[:notice] = "Successfully updated meeting type."
      redirect_to @meeting_type
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @meeting_type = MeetingType.find(params[:id])
    @meeting_type.destroy
    flash[:notice] = "Successfully destroyed time slot."
    redirect_to meeting_types_url
  end
end
