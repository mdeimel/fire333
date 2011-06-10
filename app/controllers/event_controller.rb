class EventController < ApplicationController
  def new
    date=Date.strptime(params[:date], '%m/%d/%Y')
    startTime=Time.parse(params[:start])
    startTime=startTime.change(:day=>date.day, :month=>date.month, :year=>date.year)
    endTime=Time.parse(params[:end])
    endTime=endTime.change(:day=>date.day, :month=>date.month, :year=>date.year)
    if Event.create(:title=>params[:title], :description=>params[:description], :user_id=>session[:user_id],
        :location=>params[:location], :start=>startTime, :end=>endTime)
      flash[:notice] = "Event successfully created"
    else
      flash[:error] = "Failed to create event"
    end
    redirect_to root_path
  end
  
  def show
    event = Event.find(params[:id])
    render :text => [event].to_json
  end
end
