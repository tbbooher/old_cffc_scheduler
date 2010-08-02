class TrainersController < ApplicationController
  def index
    @coachs = Trainer.all
  end
  
  def show
    @coach = Trainer.find(params[:id])
  end
  
  def new
    @coach = Trainer.new
  end
  
  def create
    @coach = Trainer.new(params[:coach])
    if @coach.save
      flash[:notice] = "Successfully created coach."
      redirect_to @coach
    else
      render :action => 'new'
    end
  end
  
  def edit
    @coach = Trainer.find(params[:id])
  end
  
  def update
    @coach = Trainer.find(params[:id])
    if @coach.update_attributes(params[:coach])
      flash[:notice] = "Successfully updated coach."
      redirect_to @coach
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @coach = Trainer.find(params[:id])
    @coach.destroy
    flash[:notice] = "Successfully destroyed coach."
    redirect_to coachs_url
  end
end
