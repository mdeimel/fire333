class EventController < ApplicationController
  before_filter :loggedin?, :except => [:show]
  
  def new
    date=params[:date].empty? ? Date.today : Date.strptime(params[:date], '%m/%d/%Y')
    startTime=params[:start].empty? ? Time.now : Time.parse(params[:start])
    startTime=startTime.change(:day=>date.day, :month=>date.month, :year=>date.year)
    endTime=params[:end].empty? ? Time.now : Time.parse(params[:end])
    endTime=endTime.change(:day=>date.day, :month=>date.month, :year=>date.year)
    event=Event.new(:title=>params[:title], :description=>params[:description], :user_id=>session[:user_id],
        :location=>params[:location], :start=>startTime, :end=>endTime)
    if event.save
      flash[:notice] = "Event successfully created"
    else
      flash[:error] = "Failed to create event for the following reasons: "
      event.errors.each { |error| flash[:error]+=event.errors[error][0]+"  " }
    end
    redirect_to root_path
  end
  
  def show
    event = Event.find(params[:id])
    render :text => [event].to_json
  end
  
  def destroy
    event = Event.find(params[:id])
    if event.user_id==session[:user_id]
      event.destroy
      flash[:notice] = "Event deleted."
    else
      flash[:error] = "Events can only be deleted by the user who created them."
    end
    redirect_to root_path
  end
end
