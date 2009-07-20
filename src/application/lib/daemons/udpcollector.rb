#!/usr/bin/env ruby

# TODO: Change this stuff
ENV["RAILS_ENV"] ||= "production"
#require 'socket'
port = 12000
bindip = "0.0.0.0"
#server = UDPSocket.open
#server.bind(nil, port)

require File.dirname(__FILE__) + "/../../config/environment.rb"
ActiveRecord::Base.logger.info "Starting UDP log collector :: listening on #{bindip}:#{port}"
#require 'collector.rb'


Signal.trap("TERM") do 
  ActiveRecord::Base.logger.info "-- Stopping UDP collector"
  EventMachine::stop_event_loop
end

EventMachine::run {
  EventMachine::open_datagram_socket bindip, port, CollectionServer
}