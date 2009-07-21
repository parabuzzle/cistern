# Cistern UDP Collector application
# This file is part of the Cistern Application
#
# Author - Mike Heijmans (parabuzzle@yahoo.com)
#
# Licensed under the MIT License
# Copyright (c) 2009 Michael Heijmans

require 'socket'
port = 11111
server = UDPSocket.open
server.bind(nil, port)
loop do
  text,sender = server.recvfrom(1024)
  puts text
end
