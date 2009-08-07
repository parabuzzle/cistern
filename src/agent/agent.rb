require 'rubygems'
require 'eventmachine'
require 'lib/modules.rb'
require 'socket'
require 'file/tail'
include File::Tail
include Socket::Constants

BREAK = "__1_BB"
VALUE = "__1_VV"
CHECKSUM = "__1_CC"
FINISH = "__1_EE"

filename = "/var/logs/auth.log"
authkey = "55bef2e25cc000d3c0d55d8ae27b6aeb"
agent_id = 1
logtype_id = 1

socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
sockaddr = Socket.pack_sockaddr_in( 9845, '127.0.0.1' )
socket.connect( sockaddr )

def send_event(entry)
  event = Hash.new
  e = String.new
  
  d = entry[0,16].split(' ')
  m = d[2].split(':')
  etime = Time.local(Time.now.year,d[0],d[1],m[0],m[1],m[2]).to_i
  loglevel_id = 4
  payload = 'EVENT/000/' + event.gsub(data[0,16], '')
  static = "<<<EVENT>>>"
  
  event.store("authkey", authkey)
  event.store("logtype_id", logtype_id)
  event.store("agent_id", agent_id)
  event.store("loglevel_id", loglevel_id)
  event.store("etime", etime)
  event.store("data", static)
  event.store("payload", payload)
  
  event.each do |key, val|
    e = e + key.to_s + VALUE + val.to_s + BREAK
  end
  e = e + CHECKSUM + Digest::MD5.hexdigest(e) + FINISH
  
  socket.write(e)
end


File.open(filename) do |log|
  log.extend(File::Tail)
  log.interval = 1
  log.backward(0)
  log.tail { |line| send_event(line) }
end


