#This initializer is used to pull in modules and extentions in other directories. (The include functions in envrionment.rb is crap)
require 'digest/md5'
require RAILS_ROOT + '/lib/modules/collection_server.rb'
require RAILS_ROOT + '/lib/modules/command_server.rb'

USEMEMCACHE = YAML::load(File.open(RAILS_ROOT + "/config/cistern.yml"))['usememcache']

#Mixin for the string class to add a validity check for log events based on the checksum appended to buffered received data
class String
  def valid?
    part = self.split('__1_CC')
    puts part[0]
    if Digest::MD5.hexdigest(part[0]) == part[1]
      return true
    else
      return false
    end
  end
end