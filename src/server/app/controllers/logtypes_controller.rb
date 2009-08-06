class LogtypesController < ApplicationController
  
  def index
    @title = "Logtypes"
    @logtypes = Logtype.paginate :all, :per_page => params[:perpage], :page => params[:page]
  end
  
  def show
    @logtype = Logtype.find(params[:id])
    if request.post?
      redirect_to :action => "search", :id => params[:id], :aquery => params[:search][:data]
    end
    @title = "All Events for #{@logtype.name}"
    if params[:loglevel].nil?
      @event = @logtype.events.paginate :all, :per_page => params[:perpage], :page => params[:page]
    else
      @event = @logtype.events.paginate :all, :per_page => params[:perpage], :page => params[:page], :conditions => "loglevel_id <= '#{params[:loglevel]}'"
    end
    @events = rebuildevents(@event)
  end
  
  def search
    if params[:aquery].nil?
      redirect_to :action => 'show', :id => params[:id]
    else
      @title = "Search Results"
      @logtype = Logtype.find(params[:id])
      @total = @logtype.events.find_with_ferret(params[:aquery]).length
      @results = @logtype.events.paginate(params[:aquery], {:finder => "find_with_ferret", :total_entries => @total}.merge({:page => params[:page], :per_page => params[:per_page]}))
    end
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
