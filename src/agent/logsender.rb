require 'socket'
require 'yaml'
require 'digest/md5'
include Socket::Constants

@break = "__1_BB"
@value = "__1_VV"
@checksum = "__1_CC"


def close_tx(socket)
  socket.write("__1_EE")
end
def newvalbr(socket)
  socket.write("__1_BB")
end
def valbr(socket)
  socket.write("__1_VV")
end
def checkbr(socket)
  socket.write("__1_CC")
end

socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
sockaddr = Socket.pack_sockaddr_in( 9845, '127.0.0.1' )
socket.connect( sockaddr )

#Things you need...
#data - static data
#logtype_id - logtype
#loglevel - The log level of the event
#time - the original time of the event
#payload - The dynamic data for the event (format - NAME=value)
#agent_id - The reporting agent's id
#
#The entire sting should have a checksum or it will be thrown out

event = Hash.new
event.store("key", "111")
event.store("data","Error log in <<<NAME>>> module")
event.store("logtype_id", 1)
event.store("loglevel_id", 2)
event.store("time", Time.now.to_f)
event.store("payload", "NAME=Biff")
event.store("agent_id", 1)

e = String.new
event.each do |key, val|
  e = e + key.to_s + @value + val.to_s + @break
end
puts e
e = e + @checksum + Digest::MD5.hexdigest(e) + "__1_EE"
puts e
socket.write(e)
socket.write(e)
socket.write(e)




