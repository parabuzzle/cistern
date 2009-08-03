require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "new event" do
    e = Event.new
    e.payload = "agent3"
    e.staticentry_id = "85d229332bf72d4539372498264300d6"
    e.agent_id = 1
    e.loglevel = 0
    e.logtype_id = 1
    e.time = 1249062105.06911
    assert e.save
  end
  
  test "invalid new event - missing agent_id" do
    e = Event.new
    e.payload = "agent3"
    e.staticentry_id = "85d229332bf72d4539372498264300d6"
    e.agent_id = nil
    e.loglevel = 0
    e.logtype_id = 1
    e.time = 1249062105.06911
    assert !e.save
  end
  
  test "invalid new event - missing loglevel" do
    e = Event.new
    e.payload = "agent3"
    e.staticentry_id = "85d229332bf72d4539372498264300d6"
    e.agent_id = 1
    e.loglevel = nil
    e.logtype_id = 1
    e.time = 1249062105.06911
    assert !e.save
  end
  
  test "invalid new event - missing time" do
    e = Event.new
    e.payload = "agent3"
    e.staticentry_id = "85d229332bf72d4539372498264300d6"
    e.agent_id = 1
    e.loglevel = 0
    e.time = nil
    e.logtype_id = 1
    assert !e.save
  end
  
  test "invalid new event - missing logtype_id" do
    e = Event.new
    e.payload = "agent3"
    e.staticentry_id = "85d229332bf72d4539372498264300d6"
    e.agent_id = 1
    e.loglevel = 0
    e.time = 1249062105.06911
    e.logtype_id = nil
    assert !e.save
  end
    
end
