#!/usr/bin/env ruby

# TODO: Change this stuff
ENV["RAILS_ENV"] ||= "production"
require 'yaml'
config = YAML::load(File.open(File.dirname(__FILE__) + "/../../config/collectors.yml"))['tcpcollector']
port = config['port']
bindip = config['listenip']

require File.dirname(__FILE__) + "/../../config/environment.rb"
ActiveRecord::Base.logger.info "Starting TCP log collector :: listening on #{bindip}:#{port}"


Signal.trap("TERM") do 
  ActiveRecord::Base.logger.info "-- Stopping TCP collector"
  EventMachine::stop_event_loop
end

EventMachine::run {
  EventMachine::start_server bindip, port, CollectionServer
}