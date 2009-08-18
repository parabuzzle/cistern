class StatsController < ApplicationController
  
  def index
    @title = "Statistics"
    @agents = Agent.all
    @logtypes = Logtype.all
    @agentscount = Agent.count
    @eventscount = Event.count
    @logtypescount = Logtype.count
    @staticscount = Staticentry.count
  end
  
end
