class EventsController < ApplicationController
  include EventsHelper
  
  def index
    @title = "Events"
    @logtypes = Logtype.all
    @agents = Agent.all
  end
  
  def show
    @title = "All Events"
    #@events = Array.new
    @event = Event.paginate :all, :per_page => params[:perpage], :page => params[:page]
    @events = rebuildevents(@event)
  end
  
end
