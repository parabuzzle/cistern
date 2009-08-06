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
  
  def new
    if request.post?
      @logtype = Logtype.new(params[:logtype])
      if @logtype.save
        flash[:notice] = "Logtype #{@logtype.name} added"
        redirect_to :action => "index"
      else
        flash[:error] = "There were errors creating your logtype"
      end
    else
      @title = "Create New Logtype"
    end
  end
  
  def edit
    @logtype = Logtype.find(params[:id])
    if request.post?
      @logtype.update_attributes(params[:logtype])
      if @logtype.save
        flash[:notice] = "Logtype #{@logtype.name} updated"
        redirect_to :action => "index"
      else
        flash[:error] = "There were errors updating your logtype"
      end
    else
      @title = "Edit #{@logtype.name}"
    end
  end
  
  def delete
    @logtype = params[:id]
    if request.post?
      if @logtype.destroy
        flash[:notice] = "Logtype deleted"
        redirect_to :action => "index"
      else
        flash[:error] = "Error trying to delete logtype"
        redirect_to :action => "index"
      end
    else
      flash[:error] = "Poking around is never a good idea"
      redirect_to :action => "index"
    end
  end
  
end
