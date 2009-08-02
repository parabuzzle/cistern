#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "production"
require 'yaml'
config = YAML::load(File.open(File.dirname(__FILE__) + "/../../config/collectors.yml"))['commandlistener']
port = config['port']
bindip = config['listenip']

require File.dirname(__FILE__) + "/../../config/environment.rb"
ActiveRecord::Base.logger.info "Starting command server :: listening on #{bindip}:#{port}"


Signal.trap("TERM") do 
  ActiveRecord::Base.logger.info "-- Stopping command server"
  EventMachine::stop_event_loop
end

EventMachine::run {
  EventMachine::start_server bindip, port, CommandServer
}