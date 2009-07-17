require 'socket'
port = 12000
server = UDPSocket.open
server.bind(nil, port)
loop do
  text,sender = server.recvfrom(1024)
  puts text
end
