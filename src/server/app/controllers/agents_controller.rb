class AgentsController < ApplicationController
  
  def index
    @title = "Agents"
    @agents = Agent.paginate :all, :per_page => params[:perpage], :page => params[:page]
  end
  
  def show
    @agent = Agent.find(params[:id])
    @title = "All Events for #{@agent.name}"
    if params[:logtype].nil? and params[:loglevel].nil?
      @event = @agent.events.paginate :all, :per_page => params[:perpage], :page => params[:page]
    elsif !params[:logtype].nil? and params[:loglevel].nil?
      @event = @agent.events.paginate :all, :per_page => params[:perpage], :page => params[:page], :conditions => "logtype_id = '#{params[:logtype]}'"
    elsif params[:logtype].nil? and !params[:loglevel].nil?
      @event = @agent.events.paginate :all, :per_page => params[:perpage], :page => params[:page], :conditions => "loglevel_id <= '#{params[:loglevel]}'"
    else
      @event = @agent.events.paginate :all, :per_page => params[:perpage], :page => params[:page], :conditions => "logtype_id = '#{params[:logtype]}' and loglevel_id <= '#{params[:loglevel]}'"
    end
    @events = rebuildevents(@event)
  end
  
  def new
    if request.post?
      @agent = Agent.new(params[:agent])
      @agent.authkey = Digest::MD5.hexdigest(@agent.hostname + Time.now.to_s)
      if @agent.save
        flash[:notice] = "Agent #{@agent.name} added -- don't forget to edit your agent to add it to your logtypes"
        redirect_to :action => "index"
      else
        flash[:error] = "There were errors creating your agent"
      end
    else
      @title = "Create New Agent"
    end
  end
  
  def edit
    @agent = Agent.find(params[:id])
    if request.post?
      params[:agent][:logtype_ids] ||= []
      @agent.update_attributes(params[:agent])
      if @agent.save
        flash[:notice] = "Agent #{@agent.name} updated"
        redirect_to :action => "index"
      else
        flash[:error] = "There were errors updating your agent"
      end
    else
      @title = "Edit #{@agent.name}"
    end
  end
  
  def delete
    @agent = params[:id]
    if request.post?
      if @agent.destroy
        flash[:notice] = "Agent deleted"
        redirect_to :action => "index"
      else
        flash[:error] = "Error trying to delete agent"
        redirect_to :action => "index"
      end
    else
      flash[:error] = "Poking around is never a good idea"
      redirect_to :action => "index"
    end
  end
  
  
end
