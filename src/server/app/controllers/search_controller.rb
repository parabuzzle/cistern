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
      @total = Event.total_hits(params[:query])
      @results = Event.paginate(params[:query], {:finder => "find_with_ferret", :total_entries => @total}.merge({:page => params[:page], :per_page => params[:per_page]}))
    end
  end
  
end
