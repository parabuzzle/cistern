class Event < ActiveRecord::Base
  belongs_to :staticentry
  belongs_to :agent
  
  #Validations
  validates_presence_of :agent_id, :loglevel, :time
   
end
