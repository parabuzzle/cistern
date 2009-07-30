class Event < ActiveRecord::Base
  belongs_to :staticentry
  belongs_to :agent
end
