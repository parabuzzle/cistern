require 'rubygems'
require 'eventmachine'
require 'lib/modules.rb'
require 'socket'
require 'file/tail'
require 'yaml'
require 'digest/md5'
require 'commands.rb'
require 'lib/sender_base.rb'
require 'timeout'
include LogHelper
include AgentCommands
include File::Tail
include Socket::Constants

CONFIG = YAML::load(File.open("config.yml"))

port = CONFIG['agent']['listenport']
bindip = CONFIG['agent']['bindip']
authkey = CONFIG['agent']['key']
agent_id = CONFIG['agent']['agent_id']

@serverhost = CONFIG['server']['hostname']
@serverport = CONFIG['server']['port']


@socket = initialize_socket(@serverport, @serverhost)


CONFIG['logtypes'].each do |l,logtype|
    x = Thread.new {
    require 'logmodels/' + logtype['modelfile']
    include eval(logtype['modelname'])
    
    File.open(logtype['logfile']) do |log|
      log.extend(File::Tail)
      log.interval = 1
      log.backward(0)
      puts "tailing #{logtype['logfile']} with logmodel #{logtype['modelname']}"
      log.tail { |line| send_event(line, @socket, authkey, logtype['logtype_id'], agent_id) }
    end   
  }
end
 

Signal.trap("TERM") do 
  EventMachine::stop_event_loop
end

EventMachine::run {
  EventMachine::start_server bindip, port, CommandServer
}


