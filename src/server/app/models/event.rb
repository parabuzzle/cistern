class Event < ActiveRecord::Base
  belongs_to :staticentry
  belongs_to :agent
  
  default_scope :order => 'time DESC'
  
  #Validations
  validates_presence_of :agent_id, :loglevel, :time
   
end
