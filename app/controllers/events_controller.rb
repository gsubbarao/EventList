class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
      if @event.save
        redirect_to root_url, :notice => "Your event created successfully."
      else
        render "new"
      end
  end

  def destroy
    User.destroy(session[:user_id])
    session[:user_id] = nil
    redirect_to root_url, :notice => "You removed your event."
  end
end
