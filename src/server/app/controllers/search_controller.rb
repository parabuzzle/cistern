class SearchController < ApplicationController
  include ApplicationHelper
  include SearchHelper
  
  def index
    @title = "Search for Events"
    if request.post?
      if params[:loglevel_ids] == "off"
        params[:loglevel_ids] = nil
      end
      if params[:logtype_ids] == "off"
        params[:logtype_ids] = nil
      end
      if params[:agent_ids] == "off"
        params[:agent_ids] = nil
      end
      #params[:search][:data]
      redirect_to :action => 'show', :query => params[:search][:data], :loglevel => params[:loglevel_ids], :logtype => params[:logtype_ids], :agent => params[:agent_ids]
    end
  end
  
  def show
    if params[:query].nil?
      redirect_to :action => 'index'
    else
      @title = "Search Results"
      if !params[:loglevel].nil?
        loglevel = params[:loglevel]
      end
      if !params[:logtype].nil?
        logtype = params[:logtype]
      end
      if !params[:agent].nil?
        agent = params[:agent]
      end
      #@results = Agent.find(agent).events.find_with_ferret(params[:query])
      r = Event.find_with_ferret(params[:query])
      @results = Array.new
      if !agent.nil?
        r = filter_agent(r,agent.to_i)
      end
      if !logtype.nil?
        r = filter_logtype(r,logtype.to_i)
      end
      if !loglevel.nil?
        r = filter_loglevel(r,loglevel.to_i)
      end
      @results = r
    end
  end
  
end
