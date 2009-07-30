class Logtype < ActiveRecord::Base
  has_many :staticentries
  has_many :events, :through => :staticentries
end
