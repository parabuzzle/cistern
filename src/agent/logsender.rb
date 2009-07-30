require 'socket'
require 'yaml'
include Socket::Constants

def close_tx(socket)
  socket.write("__1_EE")
end

socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
sockaddr = Socket.pack_sockaddr_in( 9845, '127.0.0.1' )
socket.connect( sockaddr )

#Write staticentry

socket.write( "data=this is a log entry for <<NAME>>__1_B agent=1__1_Blogtype=apache__1_B" )
socket.write("level=0__1_Btime=1248931696__1_Bpayload=PrimeTime__1_B")
close_tx(socket)

socket.write( "data=this is a log entry for <<NAME>>__1_B agent=1__1_Blogtype=apache__1_B" )
socket.write("level=0__1_Btime=1248931890__1_Bpayload=PrimeTime__1_B ")
close_tx(socket)

socket.write( "data=this is a log entry for <<NAME>>__1_Bagent=0__1_Blogtype=apache__1_B" )
socket.write("level=0__1_Btime=1248931698__1_Bpayload=Builder__1_B ")
close_tx(socket)