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
    events = Event.all
    @events = rebuildevents(events)
  end
  
end
