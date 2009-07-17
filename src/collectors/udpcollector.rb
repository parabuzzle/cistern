# Cistern UDP Collector application
# This application is part of the Cistern Application
#
# Author - Mike Heijmans (parabuzzle@yahoo.com)
#

require 'socket'
port = 12000
server = UDPSocket.open
server.bind(nil, port)
loop do
  text,sender = server.recvfrom(1024)
  puts text
end
