class SearchController < ApplicationController
  
  def index
    @title = "Search for Events"
    if request.post?
      #params[:search][:data]
      redirect_to :action => 'show', :query => params[:search][:data]
    end
  end
  
  def show
    params[:query] = params[:search][:data]
    if params[:query].nil?
      redirect_to :action => 'index'
    else
      @title = "Search Results"
      @results = Event.find_with_ferret(params[:query])
    end
  end
  
end
