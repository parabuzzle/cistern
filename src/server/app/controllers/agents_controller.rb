class AgentsController < ApplicationController
  include AgentsHelper
  
  def index
    @title = "Agents"
    @agents = Agent.paginate :all, :per_page => params[:perpage], :page => params[:page]
  end
  
  def show
    @agent = Agent.find(params[:id])
    if request.post?
      redirect_to :action => "search", :id => params[:id], :aquery => params[:search][:data]
    end
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
  
  def commands
    @agent = Agent.find(params[:id])
    if params[:command].nil?
      @title = "Available Commands for #{@agent.name}"
      @commands = get_commands(@agent)
    else
      @title = "Command output for #{params[:command]}"
      @output = get_command(@agent, params[:command])
    end
  end
  
  def search
    if request.post?
      params[:aquery] = params[:search][:data]
    end
    if params[:aquery].nil?
      redirect_to :action => 'show', :id => params[:id]
    else
      @title = "Search Results"
      @agent = Agent.find(params[:id])
      @total = @agent.events.find_with_ferret(params[:aquery]).length
      @results = @agent.events.paginate(params[:aquery], {:finder => "find_with_ferret", :total_entries => @total}.merge({:page => params[:page], :per_page => params[:per_page]}))
    end
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
