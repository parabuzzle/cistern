class Event < ActiveRecord::Base
  acts_as_ferret
  
  belongs_to :staticentry
  belongs_to :agent
  belongs_to :loglevel
  
  cattr_reader :per_page
  @@per_page = 20
  
  default_scope :order => 'time DESC'
  
  #Validations
  validates_presence_of :agent_id, :loglevel_id, :time, :logtype_id
   
end
