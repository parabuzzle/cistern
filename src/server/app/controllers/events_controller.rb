class EventsController < ApplicationController
  include EventsHelper
  
  def index
    @title = "Events"
    @logtypes = Logtype.all
    @agents = Agent.all
  end
  
  def show
    @title = "All Events"
    unless params[:loglevel].nil?
      @event = Event.paginate :all, :per_page => params[:perpage], :page => params[:page], :conditions => "loglevel_id <= '#{params[:loglevel]}'"
    else
      @event = Event.paginate :all, :per_page => params[:perpage], :page => params[:page]
    end
    @events = rebuildevents(@event)
  end
  
end
