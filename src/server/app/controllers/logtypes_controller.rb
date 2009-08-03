class LogtypesController < ApplicationController
  
  def index
    @title = "Logtypes"
    @logtypes = Logtype.paginate :all, :per_page => params[:perpage], :page => params[:page]
  end
  
  def show
    @logtype = Logtype.find(params[:id])
    @title = "All Events for #{@logtype.name}"
    @event = @logtype.events.paginate :all, :per_page => params[:perpage], :page => params[:page]
    @events = rebuildevents(@event)
  end
  
end
