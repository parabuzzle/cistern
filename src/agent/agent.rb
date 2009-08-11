require 'rubygems'
require 'eventmachine'
require 'lib/modules.rb'
require 'socket'
require 'file/tail'
require 'yaml'
require 'digest/md5'
require 'lib/commands.rb'
include AgentCommands
include File::Tail
include Socket::Constants


port = 9846
bindip = '127.0.0.1'


Signal.trap("TERM") do 
  EventMachine::stop_event_loop
end

EventMachine::run {
  EventMachine::start_server bindip, port, CommandServer
}


