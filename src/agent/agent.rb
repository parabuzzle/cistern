require 'rubygems'
require 'eventmachine'
require 'lib/modules.rb'
require 'socket'
include Socket::Constants


socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
sockaddr = Socket.pack_sockaddr_in( 9845, '127.0.0.1' )
socket.connect( sockaddr )
socket.write( "GET / HTTP/1.0\r\n\r\n" )
loop do
  #socket.write("\n")
  socket.write('Hello there')
end


# EventMachine::run {
#  connection = EventMachine::connect("localhost", 9850, CommandServer)
#   puts "connected"
#   connection.send_data "_1_1_SS::#{`ps -A | grep ruby`}::EE_1_1_"
#   
#   #connection.close_connection
#   #EventMachine::stop_event_loop
#   
# }
# puts "The event loop has ended"
#