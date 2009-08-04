class AgentsController < ApplicationController
  
  def index
    @title = "Agents"
    @agents = Agent.paginate :all, :per_page => params[:perpage], :page => params[:page]
  end
  
  def show
    @agent = Agent.find(params[:id])
    @title = "All Events for #{@agent.name}"
    if params[:logtype].nil?
      @event = @agent.events.paginate :all, :per_page => params[:perpage], :page => params[:page]
    else
      @event = @agent.events.paginate :all, :per_page => params[:perpage], :page => params[:page], :conditions => "logtype_id = '#{params[:logtype]}'"
    end
    @events = rebuildevents(@event)
  end
  
end
