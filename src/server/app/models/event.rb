class Event < ActiveRecord::Base
  include ApplicationHelper
  
  acts_as_ferret :fields => ['full_event', :etime]
  
  belongs_to :staticentry
  belongs_to :agent
  belongs_to :loglevel
  
  cattr_reader :per_page
  @@per_page = 50
  
  default_scope :order => 'etime DESC'
  
  #Validations
  validates_presence_of :agent_id, :loglevel_id, :etime, :logtype_id
  
  def full_event
    return rebuildevent(self)
  end
  
  
  
   
end
