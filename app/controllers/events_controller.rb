class EventsController < ApplicationController
  before_filter :required_user, :except => :show

  def new
    @event = Event.new
  end

  def create
    params[:event][:scheduled] = DateTime.parse(params[:event]["scheduled"])
    params[:event][:owner_id] = current_user.id
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

  def show
    @event = Event.includes(:users).find(params[:id])
  end

  def atten_or_not
    event = current_user.events.find(params[:id]) rescue nil
    unless event.nil?
      current_user.events.delete(event)
    else
    current_user.events << Event.find(params[:id])
  end
    redirect_to :back
  end

end
